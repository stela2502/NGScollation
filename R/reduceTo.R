#' @name reduceTo
#' @aliases reduceTo,NGScollation-method
#' @rdname reduceTo-methods
#' @docType methods
#' @description The main reduction function can drop both samples and genes using the colnames / rownames of the data tables
#' @param x the NGScollation object
#' @param what reduce to samples or row ids default='row'
#' @param to select these names default=NULL
#' @title description of function reduceTo
#' @export 
setGeneric('reduceTo', ## Name
	function ( x, what='row', to=NULL ) { ## Argumente der generischen Funktion
		standardGeneric('reduceTo') ## der Aufruf von standardGeneric sorgt für das Dispatching
	}
)

setMethod('reduceTo', signature = c ('NGScollation'),
	definition = function ( x, what='row', to=NULL ) {
	if ( ! is.null(to)) {
		if ( what =="row") {
		lapply( names(x$objects), 
				function ( name ) {
					if ( length(which(is.na(match(to,rownames(x$objects[[name]]@data)))==F)) > 0 ) {
						x$objects[[name]] <- reduce.Obj( x$objects[[name]], probeSets= to, name=x$objects[[name]]@name );
					}else {
						print (paste( "None of the probesets matched the probesets in",x$objects[[name]]@name, "-> keep everything!"))
					}
				} 
		)
		}else if ( what =="col" ) {
			lapply( names(x$objects), 
					function ( name ) {
						browser()
						if ( length(which(is.na(match(to,colnames(x$objects[[name]]@data))==F))) > 0 ) {
							to <- colnames(x$objects[[name]]@data)[which(is.na(match(to,colnames(x$objects[[name]]@data))==T))]
							x$objects[[name]] <- drop.samples( x$objects[[name]], probeSets= to, name=x$objects[[name]]@name );
						}else {
							print (paste( "None of the names (to) matched the sample names in",x$objects[[name]]@name, "-> keep everything!"))
						}
					} 
			)
		}else {
			stop(paste( "the option what='",what,"' is not supported!", sep="") )
		}
	}
	invisible(x)
} )
