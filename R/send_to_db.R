send_to_db <- function(con, ip, word, vote){

  this_sent <- switch(as.character(vote),
                      "1" = "Negativa", 
                      "2" = "Neutra", 
                      "3" = "Positiva")
  
  query_info <- paste0("'", ip, "', '" , 
                       word$words[1], "' ,'", 
                       this_sent, "' ,'", 
                       as.character(Sys.time()),"' ") 
  
  query_vote <- paste(
    "INSERT INTO votes (IP, word, sentiment, time) VALUES(",
    query_info, ");"
  )
  
  
  DBI::dbSendQuery(con, query_vote)
  
  return(invisible(TRUE))
  
}