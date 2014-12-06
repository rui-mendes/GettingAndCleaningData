# Getting and Cleaning Data
# Coursera
# John Hopkins University

# BRui Mendes
# ruidanielalvesmendes@gmail.com

# Define file url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
file.dest <- 'question1.csv'

# Download the file from the given URL
download.file(file.url, file.dest, method='curl' )

# Read the data
dataSet <- read.csv('question1.csv')

# Tabulate the value variable (VAL)
table(dataSet$VAL)

# Extract the value of code 24 (Property value 24 .$1000000+)
table(dataSet$VAL)[[24]]
