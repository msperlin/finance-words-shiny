tab_fin_dictionary <- bs4Dash::tabItem(
  tabName = "dictionary",
  fluidRow(
    column(width = 8,
           h1("Sobre o aplicativo"),
           includeHTML(app_sys('app/html/about.html'))
           
           # htmltools::img(src = 'www/logo2.png',
           #         href = 'https://finor.tech/en',
           #         height='50px',
           #         align = 'left')
           # )
    ),
  
))