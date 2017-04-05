library(NGScollation)

x <- loadObj( '/tmp/NGStest/test.RData' ) ## the file saved in the test_new script

## this has to be filled!

expect_equal( dim(x$objects[[1]]@annotation),c(362,6) )

expect_equal( dim(x$annotation[[1]]), c(362,6) )
expect_equal( dim(x$annotation[[2]]), c(362,7) )
x$annotation[[1]] <- x$annotation[[2]]
expect_equal( dim(x$annotation[[1]]), c(362,7) )


expect_equal( dim(x$objects[[1]]@samples),c(12,12) )

expect_equal( dim(x$samples[[1]]), c(12,12) )
expect_equal( dim(x$samples[[2]]), c(12,13) )
x$samples[[1]] <- x$samples[[2]]
expect_equal( dim(x$samples[[1]]), c(12,13) )


syncAnno(x) ## very risky as it does not check anything!

expect_equal( dim(x$objects[[1]]@annotation),c(362,7) )
expect_equal( dim(x$objects[[1]]@samples),c(12,13) )
