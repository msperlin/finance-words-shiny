connect_db <- function(){
  f_db <- get_golem_config("f_db")
  
  dir_db <- dirname(f_db)
  
  if (!fs::dir_exists(dir_db)) fs::dir_create(dir_db, recurse = TRUE)
  
  con <- DBI::dbConnect(RSQLite::SQLite(),
                        f_db)
  
  my_query <- "CREATE TABLE IF NOT EXISTS votes (
    IP TEXT,
    word TEXT,
    sentiment TEXT,
    vote_id INTEGER primary key,
    time TEXT);"
  
  DBI::dbSendQuery(con, my_query)
  
  return(con)
}

