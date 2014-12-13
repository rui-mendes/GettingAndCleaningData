# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# Define file url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
file.dest <- 'question1_quizz3.csv'

# download from the URL
download.file(file.url, file.dest, method='curl' )

# read the data
dataSet <- read.csv(file.dest)

# create vector
dataSet$agricultureLogical <- ifelse(dataSet$ACR==3 & dataSet$AGS==6,TRUE,FALSE)

# read lines
which(dataSet$agricultureLogical)

# Answer: 125, 238,262