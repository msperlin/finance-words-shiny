#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny, bs4Dash
#' @noRd
app_server <- function( input, output, session ) {
  
  # Your application server logic
  con <- connect_db()
  sample_words <- random_words(con)
  index <- reactiveVal(1)
  end_val <- reactiveVal(1)
  user_ip <- reactive({digest::digest(input$ip, 
                                      algo = "sha256", 
                                      serialize = FALSE)})
  wrd <- reactive({sample_words[index(), 2]}) 
  wrd_index <- reactive({sample_words[index(), 1]})
  choice <- reactive({input$voto})
  output$control <- reactive({index()})
  output$end_vector <- reactive({end_val()})
  
  outputOptions(output, "control", suspendWhenHidden = FALSE)
  outputOptions(output, "end_vector", suspendWhenHidden = FALSE)
  
  output$progressbar <- renderUI({
    shinyWidgets::progressBar(
      id = "pb1",
      value = index()-1,
      total = nrow(sample_words),
      status = "info",
      display_pct = F,
      striped = TRUE)
  })
  
  output$infobox <- renderUI({
    bs4Dash::infoBox(
      title = "Respostas",
      value = index()-1,
      color = 'info',
      fill = TRUE,
      width = 11
    )
  })
  
  output$question <- renderText({
    paste("A palavra", wrd(), "é:")
  })
  
  observeEvent(input$nextbutton, {
    #captando o voto
    req(choice())
    vote_index <- vote_id(choice())
    #enviando para o db
    send_to_db(con, user_ip(), wrd(), vote_index)
    # #incrementando reactiveVal para escolher a próxima palavra
    index(index() + 1)
  })
  
  output$checkpointquestion <- renderText({
    "Obrigado por votar! Aperte f5 para votar novamente."
  })
  
  observeEvent(input$yesbutton, {
    index(1)
  })
  
  observeEvent(input$nobutton,{
    end_val(end_val()+ 1)
  })
  
  output$thanks <- renderText({
    "Obrigado!"
  })
  
  output$fin_dictionary <- renderUI({
    tagList(
      box(width = 8,
          headerBorder = FALSE,
          collapsible = FALSE,
          htmltools::includeMarkdown('./inst/app/etc/fin_dict.Rmd')
      )
    )
  })
  
  output$finor <- renderUI({
    tagList(
      box(
        width = 8,
        headerBorder = FALSE,
        collapsible = FALSE,
        htmltools::includeMarkdown('./inst/app/etc/finor.Rmd')
      )
    )
  })
}
