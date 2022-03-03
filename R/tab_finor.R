tab_finor <- bs4Dash::tabItem(
  tabName = "finor",
  fluidRow(
    column(width = 8,
           htmltools::img(src = 'www/logo2.png',
                   href = 'https://finor.tech/en',
                   height='50px',
                   align = 'left')
           )
    ),
  br(),
  uiOutput('finor')  
)