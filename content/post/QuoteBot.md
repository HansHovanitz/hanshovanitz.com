+++
Categories = ["Development","GoLang"]
Description = ""
Tags = ["Development","golang"]
date = "2017-06-01T19:18:07-07:00"
menu = "main"
title = "QuoteBot"

+++

### -Slack Quotebot-

The gaming group I am part of goes back nearly two decades. Back in the early days we used IRC to communicate while outside of games. About a year ago we decided to modernize and start using Slack. One of the features that we really enjoyed while using IRC was the ability to save a quote from a group member (user). We wanted this functionality in Slack as well. After scouting around the internet we couldn't find anything that met our needs so a fellow member and I decided to make our own! 
<br>

We decided to use the `Go` language since it is something we were not particularly familiar with and this seemed like a good opportunity to learn something new. I plan to contribute to the QuoteBot to increase its functionality and will make a future post about it. 
<br>

The quotes are stored in a `MongoDB`. After getting the basic QuoteBot setup we wanted to import all of the old quotes from IRC so that they would not be lost. The quotes were stored in a messy plaintext file. I worked some regex magic and then wrote some Node.js powered `JavaScript` in order to parse, create, and then insert all of the old quotes into mongo. I primarily use Java at work so this was a good refresher of the `JavaScript`. I learned last summer during my internship at AMEX.  
<hr>

![q1](/images/quotebot_1/quote1.jpg)
<hr>
![q2](/images/quotebot_1/quote2.jpg)
<hr>

The code for the import script can be found **[here](https://github.com/HansHovanitz/Import-Stuff)**.
<br>
The master repo for the QuoteBot can be found **[here](https://github.com/Mosherr/slack-quotebot)**.

