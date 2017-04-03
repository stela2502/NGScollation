library(NGScollation)

x <- loadObj( '/tmp/NGStest/test.RData' ) ## the file saved in the test_new script

expect_equal( class(x), c("NGScollation", "R6" ))

expect_equal(dim(x$objects[[1]]@data),c(362,12))

reduceTo ( x, what='row', to=rownames(x$objects[[1]]@data)[1:100] )

lapply( x$objects, function (t) {expect_equal( dim(t@data), c(100,12)) } )

reduceTo ( x, what='col', to=colnames(x$objects[[1]]@data)[1:5] )


lapply( x$objects, function (t) {expect_equal( dim(t@data), c(100,5)) } )
