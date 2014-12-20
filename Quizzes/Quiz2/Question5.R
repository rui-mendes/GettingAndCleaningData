# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# write the file url and file destination to an object
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
dest <- 'getdata.for'

# download from the URL
download.file(url, dest, method = "curl")

# load the data
getdata <- read.fwf('getdata.for', skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))

# inspect data
head(getdata)

# calculate sum for column 4
sum(getdata$V4)

# answer: 32426.7