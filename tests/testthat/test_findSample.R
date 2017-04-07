library(NGScollation)

x <- loadObj( '/tmp/NGStest/test.RData' ) ## the file saved in the test_new script

i <- findSample(x, 'R1_S1_R2')
expect_equal(i ,c(
	"sample R1_S1_R2 is defined in sample dataset SampleType 0 and in the data objects test1, test2, test3",
	 "sample R1_S1_R2 is defined in sample dataset SampleType 1 and in the data objects test4" 
	 )
)

	