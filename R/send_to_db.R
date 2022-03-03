send_to_db <- function(con, ip, word, vote){

  query_info <- paste0("'", ip, "', '", word, "' ,'", vote,
                       "' ,'",as.character(Sys.time()),"' ") 
  
  query_vote <- paste(
    "INSERT INTO votes (IP, word_id, vote_id, time) VALUES(",
    query_info, ");"
  )
  
  
  send_vote = DBI::dbSendQuery(con,
                               query_vote)
  
}