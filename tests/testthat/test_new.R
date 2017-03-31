library(NGScollation)

load('test1.RData')

x <- NGScollation$new('name'='test', outpath="/tmp/NGStest/", entry=data)
expect_equal( x$outpath, '/tmp/NGStest/' )
expect_equal( length( x$objects),1)
expect_equal( length( x$annotation),1)
expect_equal(dim(x$annotation[[1]]), c(362, 6))
expect_equal( length( x$samples),1)
expect_equal(dim(x$samples[[1]]), c(12, 12))
expect_equal( length(x$atype2objects),1)
expect_equal( length(x$stype2objects),1)

expect_equal( length(x$atype2objects[[1]]),1)
expect_equal( length(x$stype2objects[[1]]),1)

load('test1.RData')
data@name = "test2"
add(x, data)

expect_equal( length( x$objects),2)
expect_equal( length( x$annotation),1)
expect_equal(dim(x$annotation[[1]]), c(362, 6))
expect_equal( length( x$samples),1)
expect_equal(dim(x$samples[[1]]), c(12, 12))
expect_equal( length(x$atype2objects),1)
expect_equal( length(x$stype2objects),1)
expect_equal( length(x$atype2objects[[1]]),2)
expect_equal( length(x$stype2objects[[1]]),2)

load('test1.RData')
data@annotation$test <- 0
data@name = "test3"
add(x, data)

expect_equal( length( x$objects),3)
expect_equal( length( x$annotation),2)
expect_equal(dim(x$annotation[[1]]), c(362, 6))
expect_equal(dim(x$annotation[[2]]), c(362, 7))

load('test1.RData')
data@samples$test <- 0
data@name = "test4"
add(x, data)

expect_equal( length( x$objects),4)
expect_equal( length( x$annotation),2)
expect_equal( length( x$samples),2)
expect_equal(dim(x$samples[[1]]), c(12, 12))
expect_equal(dim(x$samples[[2]]), c(12, 13))

expect_equal( names(x$objects), paste( 'test', c(1,2,3,4),sep='') )

expect_equal( 
		as.character(unlist(lapply(x$objects, function(t){ t@name } ))), 
		paste( 'test', c(1,2,3,4),sep='') 
)

