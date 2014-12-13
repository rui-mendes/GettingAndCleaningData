# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# Define file url and file destination
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
dest <- "jeff.jpg"

# Download from the URL
download.file(url, dest, mode = "wb", method = "curl")

# Load package jpeg
library(jpeg)

# Load the data
pictureData <- readJPEG('jeff.jpg', native=TRUE)

# Calculate the quantile values
quantile(pictureData, probs = c(0.3, 0.8) )

# answer
# 30%       80% 
# -15258512 -10575416