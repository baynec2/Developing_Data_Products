# Wordflock

[Wordflock](https://charliebayne.shinyapps.io/Wordflock/) is a R shiny app designed to explore frequently used terms corresponding with given twitter handles.

This is done with the intention of providing the user with a visual way to explore what is important to a given twitter user, given the assumption that words repeated the most frequently are the most importatant.

This app has two main features that the user can explore.

1. One user
2. Comparison of two users 

**Important Note** The Twitter API only allows a certain number of calls per 15 minute window. If the app is returning an error, it is likely that this limit has been exceeded. After waiting 15 minutes, the query should work.  

## One user
After entering the twitter handle that the user wishes to explore, the user can then use the slide bar to chose how many tweets to pull data from.   
After this, a word cloud is generated allowing the user to see the most frequently used words.  

For example if realDonaldTrump is provided as a twitter handle and then 500 is selected - the 500 most recent tweets from realDonaldTrump will be used to generate a word cloud displaying the most frequently used terms. 



## Comparsion of two users  
After entering both twitter handles that the user would like to compare, the user can use the slide bar to choose how many tweets to compare. 
After doing this, the user can choose to look at a wordcloud of the most common words by going to the Most shared words tab.  
The user can also choose to look at a plot of words that were shared on the same date over time.  
  
For example, if BarrackObama and MichelleObama were entered as the twitter handles to compare, and 500 was selected - the 500 most recent tweets from both of the Obamas would be compared.    
The user could then see a word cloud of terms that the two of them share the most frequently and the dates in which they both tweeted the same term. 

