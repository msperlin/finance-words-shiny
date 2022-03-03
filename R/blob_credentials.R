blob_credentials <- function(){
  #Set blob Credentials
  az_cred <- jsonlite::fromJSON("./../container_relationalblob.json")
  Sys.setenv(BLOB_URL = az_cred$URL_BLOB) 
  Sys.setenv(BLOB_TOKEN = az_cred$TOKEN_BLOB)
}
