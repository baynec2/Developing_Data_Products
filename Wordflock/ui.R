library(shiny)
library(shinythemes)
library(wordcloud2)

ui = navbarPage(theme = shinytheme("cosmo"),"WordFlock",
    tabPanel("One user",
        sidebarLayout(
            sidebarPanel(
                textInput("user","Enter a twitter handle here"),
                sliderInput("n",
                        "Number of tweets to assess",
                         min = 0, 
                         max = 1000, value = 500
                ),
            actionButton("start","Start"
            )
            ),
            mainPanel(
                wordcloud2::wordcloud2Output("wordcloud")
            )
        )
    ),
    tabPanel("Comparison of two users",
             sidebarLayout(
                 sidebarPanel(
                     textInput("user1","Enter a twitter handle here"),
                     textInput("user2", "Enter another handle here"),
                     sliderInput("n1",
                                 "Number of tweets to assess",
                                 min = 0, 
                                 max = 1000, value = 500
                     ),
                     actionButton("start2","Start"
                     )
                 ),
                 mainPanel(
                     tabsetPanel(
                         tabPanel("Most shared words", 
                                  wordcloud2::wordcloud2Output("wordcloud2")
                                  ), 
                         tabPanel("Words shared on the same date",
                                  plotly::plotlyOutput("Plot") 
                         )
                     )
                 )
             )
    )
)
