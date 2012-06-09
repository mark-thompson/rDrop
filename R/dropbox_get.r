#'Downloads a file from your Dropbox
#'
#' Currently the function does not provide much support other than retrieving the contents of whatever Dropbox file you specify. Use \code{TextConnection} to process ascii files for the time being.
#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint).
#' @param binary set if the object you are retrieving is binary.
#' @param ... optional additional curl options (debugging tools mostly)..
#' @return R object
#' @export dropbox_get
#' @examples \dontrun{
#' x <- dropbox_get(db_cred, '/folder/file.csv')
#'}
dropbox_get <- function(cred, file_to_get, curl = getCurlHandle(), 
    ..., binary = NA) {
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
                #XXX This should use the curl handle.
    if (!(exists.in.dropbox(cred, path = file_to_get, is_dir = FALSE, 
        ..., curl = getCurlHandle()))) {
        stop("File or folder does not exist", call. = FALSE)
    }
    downloaded_file <- suppressWarnings(OAuthRequest(cred, "https://api-content.dropbox.com/1/files/", 
        list(root = "dropbox", path = file_to_get), "GET", binary = binary))
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#files-GET   
