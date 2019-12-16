library(shiny)
library(rtweet)
library(wordcloud2)
library(plotly)
library(dplyr)
library(tidyr)


top100 = read.csv("www/Most_frequently_used_words.csv")
`%!in%` = Negate(`%in%`)

token = readRDS("twitter_token.rds")

shinyServer(function(input, output) {
    observeEvent(input$start,{
    
        output$wordcloud = renderWordcloud2({
        
           
            tw = rtweet::get_timeline(input$user,n = input$n,token = token)
            
            words = unlist(strsplit(tw$text, " ")) 
        
            df = as.data.frame(table(words)) %>% 
                dplyr::filter(words %!in% top100$Words)
        
            wordcloud2(df)
        
    })
    })
    observeEvent(input$start2,{
        output$wordcloud2 = renderWordcloud2({
            
            tw1 = rtweet::get_timeline(input$user1,n = input$n1,token = token)
           
            words1 = tidyr::separate_rows(tw1,text,sep = " ") %>% 
                select(text,created_at,screen_name)
            
            tw2 = rtweet::get_timeline(input$user2,n = input$n1,token = token)
 
            words2 = tidyr::separate_rows(tw2,text,sep = " ") %>% 
                select(text,created_at,screen_name)
            
            shared_1 = filter(words1, text %in% words2$text)
            shared_2 = filter(words2, text %in% words1$text)
            
            tally1 = group_by(shared_1,text) %>% 
                tally()
            
            tally2 = group_by(shared_2,text) %>% 
                tally()
            
            count = left_join(tally1, tally2, by = "text") %>% 
                tidyr::gather("user","count",2:3) %>% 
                group_by(text) %>% 
                summarise(avg = mean(count)) %>%
                filter(text %!in% top100$Words)
            
            wordcloud2(count)
            
        })
        output$Plot = plotly::renderPlotly({   
            
            tw1 = rtweet::get_timeline(input$user1,n = input$n1,token = token)
            
            words1 = tidyr::separate_rows(tw1,text,sep = " ") %>% 
                select(text,created_at,screen_name)
            
            tw2 = rtweet::get_timeline(input$user2,n = input$n1,token = token)
            
            words2 = tidyr::separate_rows(tw2,text,sep = " ") %>% 
                select(text,created_at,screen_name)
            
            shared_1 = filter(words1, text %in% words2$text)
            shared_2 = filter(words2, text %in% words1$text)
            word_time_1 = shared_1 %>% 
                mutate(created_at = lubridate::date(created_at))
            word_time_2 = shared_2 %>% 
                mutate(created_at = lubridate::date(created_at))
            
            shared_time = left_join(word_time_1,word_time_2, by = c("text")) %>% 
                filter(created_at.x == created_at.y,
                       text %!in% top100$Words) %>% 
                group_by(text,created_at.x) %>% 
                tally() %>% 
                ungroup()
        
            p1 = plotly::plot_ly(data =shared_time,x = ~created_at.x, y= ~n,
                                 marker = list(size = 10,
                                               color = 'rgba(255, 182, 193, .9)',
                                               line = list(color = 'rgba(152, 0, 0, .8)',
                                                           width = 2))) %>%
                plotly::add_trace(text = shared_time$text,
                                  hoverinfo = 'text' ) %>% 
                plotly::layout(title = "Number of times the same word was said by both twitter users on the same day",
                               xaxis = list(title = "Date",titlefont = "f"),
                               yaxis = list(title = "number of times the same word was tweeted",titlefont = "f")
                )
            p1
            
        })
    })
})

