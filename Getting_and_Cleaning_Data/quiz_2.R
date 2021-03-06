# Quiz 2

## Question 1
# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?
# 
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

### Skipped

## Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
# 
# Download the American Community Survey data and load it into an R object called
# 
# acs
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
library(sqldf)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', 'temp.csv')
acs <- read.csv('temp.csv')
print(sqldf("select pwgtp1 from acs where AGEP < 50"))

## Question 3
#Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
print(all(unique(acs$AGEP) == sqldf("select distinct AGEP from acs")))

## Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#   
#   http://biostat.jhsph.edu/~jleek/contact.html
# 
# (Hint: the nchar() function in R may be helpful)
library(XML)
library(RCurl)
page<-getURL('http://biostat.jhsph.edu/~jleek/contact.html')
page<-readLines(tc <- textConnection(page)); close(tc)
print(as.numeric(lapply(page[c(10, 20, 30, 100)], nchar)))

## Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# 
# (Hint this is a fixed width file format)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
lines <- readLines(url, n=10)
width_seq <- c(1,9,5,4,1,3,5,4,1,3,5,4,1,3,5,4,1,3)
cols <- c(
  '__', 
  'week', 
  '__', 
  'sstNino12', 
  '__', 
  'sstaNino12', 
  '__', 
  'sstNino3', 
  '__', 
  'sstaNino3', 
  '__', 
  'sstNino34', 
  '__', 
  "sstaNino34", 
  '__', 
  'sstNino4', 
  '__', 
  'sstaNino4')
d <- read.fwf(lines, width_seq, header=FALSE, skip=4, col.names=cols)
d <- d[, grep('^[^filler]', names(d))]
print(sum(d[, 4]))