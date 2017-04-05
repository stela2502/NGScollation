library(NGScollation)

x <- loadObj( '/tmp/NGStest/test.RData' ) ## the file saved in the test_new script

expect_equal( class(x), c("NGScollation", "R6" ))

expect_equal(dim(x$objects[[1]]@data),c(362,12))

reduceTo ( x, what='row', to=rownames(x$objects[[1]]@data)[1:100] )

lapply( x$objects, function (t) {expect_equal( dim(t@data), c(100,12)) } )

expect_equal( dim(x$samples[[1]]), c(12,12))
expect_equal( dim(x$samples[[2]]), c(12,13))

expect_equal( dim(x$annotation[[1]]), c(100,6))
expect_equal( dim(x$annotation[[2]]), c(100,7))


reduceTo ( x, what='col', to=colnames(x$objects[[1]]@data)[1:5] )

lapply( x$objects, function (t) {expect_equal( dim(t@data), c(100,5)) } )

expect_equal( dim(x$samples[[1]]), c(5,12))
expect_equal( dim(x$samples[[2]]), c(5,13))

expect_equal( dim(x$annotation[[1]]), c(100,6))
expect_equal( dim(x$annotation[[2]]), c(100,7))