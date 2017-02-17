
###Introduction

Pokedex is a pokemon database app based on pokeapi.co. It tells all the attributes
like name, id, height, weight, its photo, base experience, type of the selected pokemon,
along with it’s abilities, held items, moves, stats like special defence,attack,speed etc.
It also tells the locations where the selected pokemon can be found in pokemon world.





###Functionality

The app opens up with a 2 tabs, one showing the recent searched pokemons in a 
tableView format. Other one is used to search a pokemon either by it's name
or by it's id(an integer assigned to every pokemon to uniquely identify it).

After a successful search, it shows a window in which pokemon details are 
shown. Some details can be shown by pressing the buttons in that window.





###Notes

I have attempted to make it search through the core data first and then the 
api. But if you find any logic flawed, let me know.


There is one problem in this app, which I can't figure out. It is not saving 
the pokemon's photo in photo entity of core data. I have tried to find solution
to this problem, but I can't understand most of the solutions online because 
they are mostly in objective-c.


search icon By Gregor Cresnar
