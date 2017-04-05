require('R6')

#' @name NGScollation
#' @title NGScollation
#' @description  An S4 class to visualize Expression data.
#' @slot objects a data.frame containing the expression values for each gene x sample (gene = row)
#' @slot samples a data.frame describing the columnanmes in the data column
#' @slot annotation a data.frame describing the rownames in the data rows
#' @slot outpath the default outpath for the plots and tables from this package
#' @slot name the name for this package (all filesnames contain that)
#' @slot zscored genes are normalized?
#' @slot snorm samples normalized?
#' @slot usedObj here a set of used and probably lateron important objects can be saved. Be very carful using any of them!
#' @export
NGScollation <- R6Class(
		'NGScollation',
		public = list ( 
				objects=list(),
				samples=list(),
				stype2objects=c(),
				atype2objects=c(),
				objects2type=list(),
				annotation=list(),
				ranks=NULL,
				snorm=FALSE,
				zscored=FALSE,
				outpath='../outpath/',
				name='NGScollation',
				usedObj = list(),
				initialize = function ( entry=NULL, name=NULL, outpath=NULL ){
					if ( !is.null(name)) {self$name = name}
					if ( ! is.null(outpath) ) { 
						self$outpath=outpath
					}
					dir.create(outpath, showWarnings = FALSE)
					if ( ! is.null(entry) ) {
						add(self, entry)
					}
				},
				print = function(... ){
					print (paste("An object of class",class(self)[1],"with",
									length(names(self$objects)),"NGS datasets:"))
					t <- lapply( names(self$objects), function(name) { 
								print ( paste( 
												name,": an object of class",class(self$objects[[name]])[1],
												"with", ncol(self$objects[[name]]@data), "samples and",
												nrow(self$objects[[name]]@data), "genes"
										) )
							})
					invisible(self)
				}
		)
)

## obtained from https://rappster.wordpress.com/2015/04/03/r6s3-and-s4-getting-the-best-of-both-worlds/

.onAttach <- function(libname, pkgname) {
	where <- as.environment("package:NGScollation")
	clss <- list(
			c("NGScollation", "R6")
	)
	## Ensure clean initial state for subsequent package loads
	## while developing //
	sapply(clss, function(cls) {
				idx <- sapply(cls, isClass)
				suppressWarnings(try(sapply(cls[idx], removeClass,
										where = where), silent = TRUE))
			})
	## Set formal class equivalent //
	sapply(clss, function(cls) {
				try(setOldClass(cls, where = where), silent = TRUE)
			})
}
