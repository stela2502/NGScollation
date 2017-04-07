#' @name findSample
#' @aliases findSample,NGScollation-method
#' @rdname findSample-methods
#' @docType methods
#' @description searches all sample tables and reports the names of the datasets the sample is defined in.
#' @param x the NGScollation
#' @param sname the sample name as defined in the sample tables
#' @title description of function findSample
#' @export 
setGeneric('findSample', ## Name
	function (x, sname ) { ## Argumente der generischen Funktion
		standardGeneric('findSample') ## der Aufruf von standardGeneric sorgt für das Dispatching
	}
)

setMethod('findSample', signature = c ('NGScollation'),
	definition = function (x, sname ) {
		ret = NULL
	for ( name in names(x$samples) ) {
		OK = 0
		for ( cname in colnames(x$samples[[name]]) ) {
			#browser()
			if ( length( grep( sname,x$samples[[name]][,cname]))> 0 ){
				OK =1
			}
		}
		if ( OK == 1 ) {
			ret <- c(ret, paste( 
					"sample",
					sname,
					"is defined in sample dataset", 
					name, 
					"and in the data objects", 
					paste( collapse=", ",names(x$objects)[unlist(x$stype2objects[[name]])] ) 
				))
		}
	}
	if ( is.null(ret) ) {
		print ("The sample has not been found in any of the included datasets")
	}
	ret
} )
