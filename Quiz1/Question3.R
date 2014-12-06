# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com


# File url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx '
file.dest <- 'question3.xlsx'

# Download from the URL
download.file(file.url, file.dest, method='curl' )

# Load the package to read xlsx files
library(xlsx)

# Specify the rows and columns to import
rowIndex <- 18:23
colIndex <- 7:15

# Read xlsx file
dat <- read.xlsx('question3.xlsx', sheetIndex=1, rowIndex = rowIndex, colIndex = colIndex)

# Show head
head(dat)

# Perform the required test
sum(dat$Zip*dat$Ext,na.rm=T)

#The answer is 36534720
