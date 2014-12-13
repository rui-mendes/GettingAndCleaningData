# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# write the file url and file destination to an object
url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
dest <- 'contact.html'

# download from the URL
download.file(url, dest)

# set up a connection
con <- file('contact.html')


# read the lines
lines <- readLines(con)

# count the number of characters for each object (by specific lines)
print(nchar(lines[c(10, 20, 30, 100)]))

#close the connection
close(con)

# answer: 45 31  7 25