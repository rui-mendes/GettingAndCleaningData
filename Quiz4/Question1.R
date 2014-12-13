# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com


# download data
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv '
dest <- 'HID.csv'
download.file(url, dest, method='curl')

# load the data
dataFile <- read.csv(dest)

# extract names
names <- names(dataFile)

# string split
strsplit(names, 'wgtp')[123]

# answer: ""   "15"