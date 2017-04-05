#' @name syncAnno
#' @aliases syncAnno,NGScollation-method
#' @rdname syncAnno-methods
#' @docType methods
#' @description copy the putatives modified annotation and samples tables from the x object into the x$object(s)
#' @param x the NGScollation object
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
				x$objects[[name]]@annotation <- x$annotation[[x$objects2type[[name]][2]]]
				x$objects[[name]]@samples <- x$samples[[x$objects2type[[name]][1]]]
			} )
	invisible(x)
} )
