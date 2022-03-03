df_info_votes <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      choice <- input$voto
      req(choice)
      # 
      # #incrementando reactiveVal para escolher a próxima palavra
      index(index() + 1)
      
      #criando df
      df_info <- reactive({
        data.frame(Time = Sys.time(), 
                   ip = user_ip(), 
                   word = wrd(), 
                   vote = choice())
      })
      return(df_info)
      
    }
  )
} 

