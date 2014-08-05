#' Read CSV files stored in Dropbox
#'
#' This function is a simple wrapper around \code{\link{dropbox_get}} for csv files.
#' @param dropbox_credentials Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @param ...  additional arguments passed on to \code{\link{dropbox_get}}
#' @export
#' @seealso dropbox_get
#' @return data.frame
#' @examples \dontrun{
#' my_data <- db.read.csv(db_cred, 'data.csv', header = TRUE)
#'}
db.read.csv <- function(dropbox_credentials, file_to_get, ...)
{
    file <- dropbox_get(dropbox_credentials, file_to_get, ...)
    
    tcon <- textConnection(file[1])
    dat <- read.csv(tcon)
    close(tcon)
    
    return(dat)
}


#' Save a local copy of XLSX file from Dropbox
#'
#' This function is a simple wrapper around \code{\link{dropbox_get}} which writes raw bytes to a local xlsx file as specified by file_to_write
#' @param dropbox_credentials Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @param  file_to_write Specifies the path to the local file you want to write.
#' @param ...  additional arguments passed on to \code{\link{dropbox_get}}
#' @export
#' @seealso dropbox_get
#' @return NULL
#' @examples \dontrun{
#' db.get.xlsx(db_cred, 'dropbox_folder/file.xlsx', 'local_folder/file.xlsx')
#'}
db.get.xlsx <- function(dropbox_credentials, file_to_get, file_to_write, ...)
{
    file <- dropbox_get(dropbox_credentials, file_to_get, ...)
    attributes(file) <- NULL
    
    ftag <- file(file_to_write,'wb')
    writeBin(file, ftag)
    close(ftag)
}

