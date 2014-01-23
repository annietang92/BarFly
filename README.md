## BarFly - A Social Drinking and Bar Discovery Rails App
### Annie Tang (yuetang@mit.edu)
### http://bar-fly.herokuapp.com


##Milestone 2

**1. Did any of your answers to Milestone 1 change (particularly the Additional Questions, your idea for your site, or team members)? Write the numbers for the questions whose answers have changed, and their new answers.**

No changes since milestone 1

**2. Which features are implemented. To what extent are they complete?**

A user can log in, connect to their facebook account, follow other users, and record a drink that they drank either at a specific venue or without a venue. A user can also see a live feed of what his/her friends are drinking

**3. Are there any features you wanted to include in your MVP from Milestone 1 that are not complete? If so, which are they?**

Discovery features have not been made yet, such as finding the top bars in the users location, finding the best drinks, etc. Awards (badges) have also not yet been implemented, and recommendations as well. The beer and cocktail databases have been scraped from BreweryDB and Wikipedia (respectively) but are not complete due to limitations on heroku database sizes - will find some kind of workaround for this.

**4. What additional features do you wish to implement? How far along on those features are you?**

Discovery features, Awards, and Recommendations need to be implemented. There is 0 styling so far, so that also needs to be done. The models for these remaining features are been set up, just need to figure out the views and forms.

**5. What technologies are you using for the back-end? Include any frameworks if relevant.**

Ruby on Rails

**6. What technologies are you using for the front-end? Include Javascript frameworks such as jQuery, templating frameworks such as Handlebars.js, and other client-side frameworks such as Ember.js or Backbone.js.**

Javascript, jQuery, sass css

**7. What is the main browser you are targeting? Must be one of our supported browsers.**

Chrome

**8. What implementation unknown / risks are you still facing? Consider this an exercise of imagination, not a test of confidence.**

Limited database on heroku (max 10,000 entires)

***

## Milestone 1

**Description**

Social drinking just became even more social! BarFly is a social discovery application that lets you find the trendiest bars and drinks in your city and share the beverages you’re trying with your friends via a twitter-like feed. BarFly will easily let you find nearby bars and pubs, see which beers, wines and cocktails are trending, and see what your friends are drinking at each location. As you make your way across all the bars in town, you’ll fill up your Drinkery Passport, collect memorabilia (achievements) and perhaps become the Lord of the BarFlies in your city.
***
**User Research**

**1.Problem to Address**

There are many apps that allow people to discover the best clubs, bars, and restaurants in town, but there’s nothing that allows someone to discover what drinks are popular in their local area and keep track of which ones they’ve personally tried. Especially when someone is new to the social drinking scene, it is easy to just stick to one safe and common drink such as a long island or screwdriver, but this app will encourage users to try new brews and cocktails through seeing what other people are drinking.

**2.Killer Features**

_Discovery_

Bars/Pubs - find bars and pubs in your city, see/give reviews<br>
Drinks - log what drinks you’ve tried, give reviews and see which drinks are trending in bars around you<br>
Recommendations - based on what you like, we’ll recommend some drinks for you to try Wishlist - create a wishlist of drinks you want to try in the future

_Social_

Follow people - see what your friends are drinking, toast them, and comment<br>
Discover Barflies - see what the top drinkers are up to and follow them 

_For Fun_

Drinkery Passport - your passport gets “stamped” every time you go to a new bar/pub<br>
Memorabilia - you can collect different kinds of memorabilia when you try different drinks<br>
Fly Status - you start out as an insignificant fruit fly, but as you visit bars and try more drinks you inch closer to becoming a true barfly

**3.Target Demographic**

Adults 21 - 30 who live in a city, frequent the bar scene, do not have a family yet, and are young and social

**4.Use Cases**

_Discovering Bars_

| User          | Application     |
| ------------- |-------------|
| Moves to a new city                         |                                 | 
| Wants to grab a few drinks with a friend    |                                 | 
| Doesn’t know which places are good in town  |                                 | 
| Opens up BarFly app                         |                                 | 
| Clicks button to show bars in area          |                                 | 
|                                             | Displays map with bar locations |
| Hovers over a location                      |                                 |
|                                             | Display reviews, friends who have been at that bar and the top drinks |
| Clicks a location                           |                                 | 
|                                             | Brings up page for that bar where the user can check in, write a comment or log which beers they have tried |

_Following Friends_

| User          | Application     |
| ------------- |-------------|
| Registers via facebook          |                                              | 
|                                 | Displays users friends who use BarFly        | 
| Chooses which friends to follow |                                              | 
|                                 | Shows updated news feed with friends actions | 


***

**Site Design**

1.Most complicated page
  
The discovery page will be complicated because it needs to be able to display a lot of information. It needs to let the user discover local bars and drinks that are popular nearby. Because this will be location based, a map will also need to be incorporated. Displaying ever expanding things such as ‘friends who have been here’ and ‘drinks at this location’ is difficult because you need to accommodate for places that might have only one friend/drink or 50 friends/drinks.

![ScreenShot](http://github.mit.edu/mit6470/annietang/raw/master/Images/Milestone1_options.jpg)

2.Pros and Cons

_Option #1_

| Pros          | Cons     |
| ------------- |-------------|
| Large visible map | Split screen might be hard to see content on left side |
| Can see list of bars and their location on map | User has to go through drop down selection to see top drinks |
| Can see list of drinks | Might be kind of boring, pretty standard |
| Can list out friends and top drinks at each location indefinitely | |

_Option #2_

| Pros          | Cons     |
| ------------- |-------------|
| Top drinks are immediately visible | Split screen might be hard to see content on left side |
| Can see list of bars and their location on map | No map so can't visualize location of bars |
| Can list out friends and top drinks at each location indefinitely | |

_Option #3_

| Pros          | Cons     |
| ------------- |-------------|
| Can see map only on hover | Top drinks and friends cannot be added indefinitely (limited |
| Large images of bars and drinks | Hover map doesn't show the bar's location relative to other bars |
| Unique layout | |

3. Mockup of Option #1

![ScreenShot](http://github.mit.edu/mit6470/annietang/raw/master/Images/Mockup.png)

***

**Additional Questions**

**1.Team**<br>
  Annie Tang (MIT ‘14)<br>
	yuetang@mit.edu<br>
	course: 4<br>
	undergraduate

**2.Theme**<br>
	1 - Urban Living<br>
	BarFly is about discovering popular bars and drinks in your city

**3.Technology**<br>
	Ruby on Rails

**4.Risks**<br>
	Working with external API’s (Facebook for login, Foursquare for querying for bars) and 
scraping data for beers, wines and cocktails

**5.Competition**<br>
	Yes, I am planning on competing in the regular division


