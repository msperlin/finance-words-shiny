random_words <- function(con){

  get_nwords <- 15

  query_sample <- paste("select * from votes")
  
  df_votes =  DBI::dbGetQuery(con, query_sample)
  
  available_words <- get_words()
  
  if (nrow(df_votes) == 0) {
    selected_words <- sample(available_words, get_nwords)
    
  } else {
    # get frequency
    df_count <- df_votes |>
      dplyr::bind_rows(
        dplyr::tibble(
          word = available_words
        )
      ) |>
      dplyr::group_by(word) |>
      dplyr::count() |>
      dplyr::ungroup() |>
      dplyr::arrange(-n) 

    df_selected <- df_count |> 
      dplyr::slice(get_nwords:nrow(df_count)) |>
      dplyr::slice_sample(n = get_nwords)
      
    selected_words <- df_selected$word
  }
  
  df_words <- dplyr::tibble(
    idx = 1:length(selected_words),
    words = selected_words
  )
  
  return(df_words)
}

get_words <- function() {
  #f_csv <- app_sys("app/data/palavras_teste.csv")
  f_csv <- app_sys("app/data/formalwords.csv")

  df_words = readr::read_csv(f_csv, col_names = "word",
                             show_col_types = FALSE)
  
  return(df_words$word)
}
