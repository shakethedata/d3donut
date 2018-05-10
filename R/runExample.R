#' Run example Shiny app
#'
#' @return
#' @export
#'
#' @examples
runExample <- function() {
  appDir <- system.file("application", package = "d3donut")
  if (appDir == "") {
    stop("Could not find myapp. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}