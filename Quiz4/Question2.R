# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# download data
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
dest <- 'GDP.csv'
download.file(url, dest, method='wget')

# load the data
dataFile <- read.csv(dest, skip=4, nrows=190)


# replace comma's out
GDPrep <- gsub(",", "", dataFile$X.4)

# convert to integer and calculate mean
GDPrep <- as.integer(GDPrep)
mean(GDPrep, na.rm=TRUE)

#answer: 377652.4


countryNames <- dataFile$X.3
grep("^United", countryNames, value = TRUE)

# answer: grep("^United",countryNames), 3