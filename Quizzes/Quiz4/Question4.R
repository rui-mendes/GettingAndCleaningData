# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# download data from 1st url
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
dest <- 'GDP.csv'
download.file(url, dest, method='wget')

# load the data
GDP <- read.csv(dest, skip=4, nrows=190)

# download data from 1st url
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
dest <- 'EDU.csv'
download.file(url, dest, method='wget')

# load the data
EDU <- read.csv(dest)

# merge the datasets
merged <- merge(GDP, EDU, by.x = 'X', by.y = 'CountryCode')

# extract the information
fy.june <- grep('Fiscal year end: June', merged$Special.Notes)
length(fy.june)

# answer: 13