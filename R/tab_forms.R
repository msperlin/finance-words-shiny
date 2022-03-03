vote_options <- data.frame(voto = c("Negativa", "Neutra", "Positiva"), 
                           voto_id = c(1, 2, 3))
get_nwords <- 15

tab_forms<- bs4Dash::tabItem(
  tabName = "forms",
  fluidRow(
    column(width = 8,
           htmltools::img(src = 'www/logo2.png',
                   href = 'https://finor.tech/en',
                   height='50px',
                   align = 'left')
           )
    ),
  br(),
  bs4Dash::box(
    width = 12,
    collapsible = F,
    headerBorder = F,
    fluidRow(
      column(
        8,
        #in serverside
        uiOutput("progressbar")
        ),
      column(
        4,
        #in serverside
        uiOutput("infobox")
      )
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      conditionalPanel(
        condition = paste("output.control <", get_nwords+1),
        bs4Dash::box(
          id = "boxform",
          title = "Responda as questões a seguir:", 
          width = 12,
          status = "danger", 
          closable = FALSE,
          maximizable = FALSE, 
          collapsible = FALSE,
          shinyWidgets::awesomeRadio(
            inputId = "voto",
            label = textOutput("question"), 
            choices = vote_options[,1],
            selected = "",
            inline = TRUE, 
            status = "success")
          )
        ),
      conditionalPanel(
        condition = paste("output.control ==", get_nwords+1, "&& output.end_vector == 1"),
        bs4Dash::box(
          id = "checkpointbox", 
          title = "Obrigado pela participação!",
          width = 12,
          status = "danger", 
          closable = FALSE,
          maximizable = FALSE, 
          collapsible = FALSE,
          textOutput("checkpointquestion")
          )
        ),
    
    conditionalPanel(
      condition = "output.end_vector == 2",
      bs4Dash::box(
        id="thanksbox",
        width = 6,
        collapsible = FALSE,
        textOutput("thanks"),
        tags$head(tags$style("#thanks{color: #123573;
                                      font-size: 20px;
                                      font-style: normal;
                                      font-weight: bold;
                             }"))
        )
      )
    )
    ),
  
  fluidRow(
    conditionalPanel(
      condition = paste("output.control <", get_nwords+1),
      shinyWidgets::actionBttn(
        inputId = "nextbutton",
        label = "Próxima",
        style = "unite", 
        color = "danger")
    ),
    column(
      width = 1,
      conditionalPanel(
        condition = paste("output.control ==", get_nwords+1, "&& output.end_vector == 1"),
        shinyWidgets::actionBttn(
          inputId = "yesbutton",
          label = "Sim",
          style = "unite",
          color = "royal")
      )),
    column(
      width = 1,
      conditionalPanel(
        condition = paste("output.control ==", get_nwords+1, "&& output.end_vector == 1"),
        shinyWidgets::actionBttn(
          inputId = "nobutton",
          label = "Não",
          style = "unite",
          color = "success")
        )
      )
    ),
  fluidRow(
    tags$script('
  var coords = $.getJSON("https://ipapi.co/json/", function(data) {
   Shiny.setInputValue("ip", data.ip); //set value from data.ip in js to input$ip in R
  });'
    ),
  verbatimTextOutput("value")
  )
)