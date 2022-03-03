vote_id <- function(vote){
  # vote_index <- vote_options %>% 
  #   filter(voto == vote) %>% 
  #   select(2)
  vote_id1 <- dplyr::filter(vote_options, voto == vote)
  vote_id2 <- dplyr::select(vote_id1, 2)
  
  return(vote_id2[1,1])
}

