create_db <- function( name = NULL){
  db_name<- paste(name, ".db", sep = "")
  RSQLite::dbConnect(RSQLite::SQLite(), db_name)
}