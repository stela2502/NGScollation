syncAnno <- function(x) {
	lapply(names(x$objects), function( name) {
				x$objects@annotation <- x$annotation[[x$objects2type[[name]][2]]]
				x$objects@samples <- x$samples[[x$objects2type[[name]][1]]]
			} )
	invisible(x)
}