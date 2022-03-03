random_words <- function(con){

  get_nwords <-15

  query_sample <- paste("select * from votes")
  
  df_votes =  DBI::dbGetQuery(con, query_sample)
  
  if (nrow(df_votes) == 0) {
    all_words <- sample(get_words(), get_nwords)
    
  } else {
    x <- 1
    browser()
  }
  
  all_words
  
  return(all_words)
}

get_words <- function() {
  f_csv <- app_sys("app/data/palavras_teste.csv")
  
  df_words = readr::read_csv(f_csv, col_names = "word")
  return(df_words$word)
}
