send_to_blob <- function(df_votes) {
  #Set env vars
  blob_credentials()
  # browser()
  #Authenticate access to blob
  fl_endp_sas <- AzureStor::storage_endpoint(
    Sys.getenv('BLOB_URL'), 
    key =Sys.getenv('BLOB_TOKEN'))
  
  #Set target container to upload
  cont <- AzureStor::storage_container(fl_endp_sas, "finance-dictionary")
  
  #send df as csv
  AzureStor::storage_write_csv(df_votes,
                              container = cont,
                              file = fs::path(
                                Sys.time(),
                                ext='csv')
  )
   
}

