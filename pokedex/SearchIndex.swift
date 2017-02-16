//
//  SearchIndex.swift
//  pokedex
//
//  Created by Nitish on 14/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import Foundation
import CoreData

/*var instanceOfFMDB : FMDB = FMDB()
instanceOfFMDB.logsErrors = false
print(instanceOfFMDB.logsErrors)*/



//http://codelle.com/blog/2016/3/simple-core-data-full-text-search-with-swift-and-sqlite/

protocol Searchable {
    var searchableStrings: [String] { get}
    
    var URIRepresentation: NSURL{ get}
    
}

extension Searchable where Self: NSManagedObject{
    var URIRepresentation: NSURL{
        return objectID.uriRepresentation() as NSURL
    }
}

class SearchIndex{
    let databaseQueue: FMDatabaseQueue
    
    init() {
        let path = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appendingPathComponent("SearchOmdex.sqlite").path
        databaseQueue = FMDatabaseQueue(path: path)
        
        databaseQueue.inTransaction { (database, rollback) in
            do{
                try database?.executeUpdate("CREATE VIRTUAL TABLE IF NOT EXISTS documents using fts4(tokenize=unicode61, identifier, contents);", values: [])
            }catch{
                print("Warning: Searh Index create failed")
            }
        }
    }
    
    
    func insertSearchable(object: Searchable){
    databaseQueue.inDatabase { (database) in
        do{
            try database?.executeUpdate("DELETE FROM documents WHERE identifier = ?", values: [object.URIRepresentation.absoluteString!])
            try database?.executeUpdate("INSERT INTO documents (identifier, contents) VALUES(?, ?);", values: [object.URIRepresentation.absoluteString!, object.searchableStrings.joined(separator: " ")])
            }catch{
                print("Warning: Search Index failed: \(error)")
            }
        }
    }
    
    func deleteSearchable(object: Searchable) {
        databaseQueue.inDatabase { (database) in
            do{
                try database?.executeUpdate("DELETE FROM documents where identifier = ?;", values: [object.URIRepresentation.absoluteString!])
            }catch{
                print("Warning: Search Index insert failed: \(error)")
            }
        }
    }
    
    func searchForURIsWithQuery(query: String) -> [NSURL] {
        var objects = [NSURL]()
        
        databaseQueue.inDatabase { (database) in
            let results: FMResultSet!
            do{
                results = try database?.executeQuery("SELECT identifier FROM documents WHERE contents MATCH ?;", values: [query])
            }catch{
                print("Waring: Search Index query failed: \(error)")
                return
            }
            
            while results.next(){
                objects.append(NSURL(string: results.string(forColumn: "identifier"))!)
            }
        }
            return objects
    }
    
    func searchForManagedObjectsWithQuery(query: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject]{
        return searchForURIsWithQuery(query: query).flatMap({ (uri) in
            if let objectID = managedObjectContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri as URL){
                return managedObjectContext.object(with: objectID)
            }else{
                return nil
            }
        })
    }
}
