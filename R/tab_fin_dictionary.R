tab_fin_dictionary <- bs4Dash::tabItem(
  tabName = "dictionary",
  fluidRow(
    column(width = 8,
           htmltools::img(src = 'www/logo2.png',
                   href = 'https://finor.tech/en',
                   height='50px',
                   align = 'left')
           )
    ),
  br(),
  uiOutput('fin_dictionary')  
)