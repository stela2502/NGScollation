setGeneric('add', ## Name
	function (x, entry, ...  ) { ## Argumente der generischen Funktion
		standardGeneric('add') ## der Aufruf von standardGeneric sorgt für das Dispatching
	}
)

#' @name add
#' @aliases add,NGScollation-method
#' @rdname add-methods
#' @docType methods
#' @description Add a StefansExpressionSet to the NGScollation object
#' @param x the NGScollation object
#' @param entry an object of package StefansExpressionSet
#' @param stype the type of the samples default=NULL
#' @param atype the type of the annoation default=NULL
#' @title description of function add
#' @export 
setMethod('add', signature = c ('NGScollation'),
	definition = function (x, entry, stype=NULL, atype=NULL ) {
		if ( ! attr(class(entry),'package') == "StefansExpressionSet") {
			stop ( "Sorry, but you can only add a StefansExpressioSet object to this class!")
		}
		## add the enry to the objects list
		if ( is.na(match(entry@name,names(x$objects)) ) ){
			x$objects[[length(x$objects)+1]] = entry
			names(x$objects)[length(x$objects)] = entry@name
		}else {
			stop( paste("The object",entry@name,"has already been added here!" ))
		}
		if ( is.null(stype) ) {
			stype = paste("SampleType",length(x$stype2objects) )
			for ( type in names(x$stype2objects) ) {
				if ( isTRUE( all.equal ( x$objects[[x$stype2objects[[type]][[1]]]]@samples, entry@samples ) ) ){
					stype = type
				}
			}
		}
		if ( is.null(x$stype2objects[[stype]])) {
			x$samples <- add( x$samples, entry@samples, name=stype )
			x$stype2objects[[stype]] <- list()
			x$stype2objects[[stype]][[1]] = length(x$objects)
		}else {
			x$stype2objects[[stype]][[length(x$stype2objects[[stype]])+1]] = length(x$objects)
		}
		
		if ( is.null(atype) ) {
			atype = paste("AnnotationType",length(x$atype2objects) )
			for ( type in names(x$atype2objects) ) {
				if (isTRUE( all.equal ( x$objects[[x$atype2objects[[type]][[1]]]]@annotation, entry@annotation ) )){
					atype = type
				}
			}
		}
		if ( is.null(x$atype2objects[[atype]])) {
			x$annotation <- add( x$annotation, entry@annotation, name=atype )
			x$atype2objects[[atype]] <- list()
			x$atype2objects[[atype]][[1]] = length(x$objects)
		}else {
			x$atype2objects[[atype]][[length(x$atype2objects[[atype]])+1]] = length(x$objects)
		}
		
		x$objects2type <- add( x$objects2type, c(stype,atype), as.character(length(x$objects) ))
		
		invisible(x)
} )

#' @name add
#' @aliases add,list-method
#' @rdname add-methods
#' @docType methods
#' @description add an entry into a list
#' @param x a list
#' @param entry the new entry
#' @param name the name of the enw entry (optional)
#' @param replace allow replacement default T
#' @title description of function add
#' @export 
setMethod('add', signature = c ('list'),
		definition = function (x, entry, name=NULL, replace=T ) {
			if ( ! is.null(name) ) {
				if ( ! is.na(match(name,names(x)) ) ){
					if ( replace ) {
						x[[match(name,names(x))]] = entry
					}else {
						stop( paste("the entry", name, "has already been added here!" ) )
					}
				}else { ## new
					x[[length(x) +1]] = entry
					names(x)[length(x)] = name
				}
			}else {
				x[[length(x) +1]] = entry
				names(x)[length(x)] = name
			}
			x
		} 
)



