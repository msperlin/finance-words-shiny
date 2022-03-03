connect_db <- function(){
  con <- DBI::dbConnect(RSQLite::SQLite(),
                        "~/Desktop/db2.sqlite")
  
  my_query <- "CREATE TABLE IF NOT EXISTS votes (
    IP TEXT,
    word_id INTEGER primary key,
    vote_id INTEGER,
    time TEXT);"
  
  send_vote = DBI::dbSendQuery(con,
                               my_query)
  
  return(con)
}

