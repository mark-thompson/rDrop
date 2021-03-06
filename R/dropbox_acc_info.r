#'Retrieve Dropbox account summary
#'
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @export dropbox_acc_info
#' @keywords authentication OAuth
#' @seealso related: \code{\link{dropbox_auth}}
#' @return list containing \item{referral link}{Dropbox referral link.} \item{display_name}{Dropbox display name} \item{uid}{Dropbox user id} \item{country}{Dropbox country} \item{quota_info}{Information on shared, quota, and normal.} \item{email}{Dropbox user email}
#' @examples \dontrun{
#' dropbox_acc_info(db_cred)
#'}
dropbox_acc_info <-
function(cred, curl = getCurlHandle(),  ...) {
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    info <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/account/info", 
                                  ..., curl = curl))
    return(info)
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#account-info   
