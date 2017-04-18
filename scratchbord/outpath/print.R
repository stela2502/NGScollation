#' @name print
#' @aliases print,NGScollation-method
#' @rdname print-methods
#' @docType methods
#' @description 
#' @param x  TEXT MISSING
#' @title description of function print
#' @export 
setGeneric('print', ## Name
	function (x) { ## Argumente der generischen Funktion
		standardGeneric('print') ## der Aufruf von standardGeneric sorgt für das Dispatching
	}
)

setMethod('print', signature = c ('NGScollation'),
	definition = function (x) {
print (paste("An object of class",class(x)[1],"with",
				length(names(x$objects)),"NGS datasets:"))
t <- lapply( names(x$objects), function(name) { 
			print ( paste( 
							name,": an object of class",class(x$objects[[name]])[1],
							"with", ncol(x$objects[[name]]@data), "samples and",
							nrow(x$objects[[name]]@data), "genes"
					) )
		})
} )
