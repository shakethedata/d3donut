#' R fuction linked to d3donut d3.js script
#'
#' Standard htmlwidget code for linking R function to d3donut d3.js script.
#'
#' @import htmlwidgets
#'
#' @export
d3donut <- function(message, width = NULL, height = NULL, elementId = NULL) {
  
  # forward options using x
  x = list(
    message = message
  )
  
  # create widget
  htmlwidgets::createWidget(
    name = 'd3donut',
    x,
    width = width,
    height = height,
    package = 'd3donut',
    elementId = elementId
  )
}

#' Shiny bindings for testD3
#'
#' Output and render functions for using testD3 within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a testD3
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name d3donut-shiny
#'
#' @export
d3donutOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'd3donut', width, height, package = 'd3donut')
}

#' @rdname d3donut-shiny
#' @export
renderD3donut <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, d3donutOutput, env, quoted = TRUE)
}