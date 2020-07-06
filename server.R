# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  
  library(tidyverse)
  library(lubridate)
  

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderTable({


    meetups <- readRDS("data/r_meetups.RDS")


    whats_on <- function(topic, meetups_df, links_only = FALSE) {

    this_week <- meetups %>%
      mutate(date = your_local_time %>% as.Date) %>%
      filter(date >= today() & date <= today() + 7)

    if(links_only) {

      this_week <- filter(map_lgl(zoom_links, ~ .x %>% length %>% {. != 0}) |
           map_lgl(meet_links, ~ .x %>% length %>% {. != 0}) |
           map_lgl(youtube_links, ~ .x %>% length %>% {. != 0}) |
           map_lgl(facebook_links, ~ .x %>% length %>% {. != 0}) |
           (!is.na(find_us)) & online == TRUE)
      }

        this_week %>%
          mutate(available_links = mapply(c, find_us, zoom_links, meet_links, youtube_links, facebook_links)) %>%
          mutate(available_links = map_chr(available_links, ~ paste0(.x, collapse= ", ") )) %>%
          select(group, name, desc_clean, available_links, your_local_time, link) %>%
          arrange(your_local_time)


    }





      whats_on("r-project-for-statistical-computing", meetups)


    
    
    
    
    

    })

}