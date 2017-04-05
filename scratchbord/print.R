print <- function(x) {
print (paste("An object of class",class(x)[1],"with",
				length(names(x$objects)),"NGS datasets:"))
t <- lapply( names(x$objects), function(name) { 
			print ( paste( 
							name,": an object of class",class(x$objects[[name]])[1],
							"with", ncol(x$objects[[name]]@data), "samples and",
							nrow(x$objects[[name]]@data), "genes"
					) )
		})
}