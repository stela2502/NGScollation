#' @name syncAnno
#' @aliases syncAnno,NGScollation-method
#' @rdname syncAnno-methods
#' @docType methods
#' @description 
#' @param x  TEXT MISSING
#' @title description of function syncAnno
#' @export 
setGeneric('syncAnno', ## Name
	function (x) { ## Argumente der generischen Funktion
		standardGeneric('syncAnno') ## der Aufruf von standardGeneric sorgt für das Dispatching
	}
)

setMethod('syncAnno', signature = c ('NGScollation'),
	definition = function (x) {
	lapply(names(x$objects), function( name) {
				x$objects@annotation <- x$annotation[[x$objects2type[[name]][2]]]
				x$objects@samples <- x$samples[[x$objects2type[[name]][1]]]
			} )
	invisible(x)
} )
