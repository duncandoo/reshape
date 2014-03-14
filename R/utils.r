"%||%" <- function(a, b) if (!is.null(a)) a else b

all_identical <- function(xs) {
  if (length(xs) <= 1) return(TRUE)
  for (i in seq(2, length(xs))) {
    if (!identical(xs[[1]], xs[[i]])) return(FALSE)
  }
  TRUE
}

## Get the attributes if common, NULL if not.
get_measure_attributes <- function(data, measure.ind, factorsAsStrings) {

  measure.attributes <- lapply(measure.ind, function(i) {
    attributes(data[[i]])
  })

  ## Determine if all measure.attributes are equal
  measure.attrs.equal <- all_identical(measure.attributes)

  if (measure.attrs.equal) {
    measure.attributes <- measure.attributes[[1]]
  } else {
    warning("attributes are not identical across measure variables; ",
      "they will be dropped")
    measure.attributes <- NULL
  }

  if (!factorsAsStrings && !measure.attrs.equal) {
    warning("cannot avoid coercion of factors when measure attributes not identical")
    factorsAsStrings <- FALSE
  }

  ## If we are going to be coercing any factors to strings, we don't want to
  ## copy the attributes
  any.factors <- any( sapply( measure.ind, function(i) {
    is.factor( data[[i]] )
  }))

  if (factorsAsStrings && any.factors) {
    measure.attributes <- NULL
  }

  return(measure.attributes)

}
