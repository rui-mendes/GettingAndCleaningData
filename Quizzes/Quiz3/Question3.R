# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com


# write the file url and file destination to an object
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
dest <- 'GDP.csv'

# download from the URL
download.file(url, dest, method = "curl")

# specify the right lines
rowNames <- seq(10,200, 2)

# read the data
gdp <- read.csv('GDP.csv', header=F, skip=5, nrows=190)
View(gdp)

# second data file
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
dest <- 'STATS.csv'

# download from the URL
download.file(file.url, file.dest, method = "curl")

# read second file
fed <- read.csv('STATS.csv')
View(fed)

# merge datasets
combined <- merge(gdp, fed, by.x='V1', by.y='CountryCode', sort=TRUE)
print(nrow(combined))
View(combined)

# Q3.
# sort the data
combined[with(combined, order(-V5) )]
names(combined)

combinedOrdered <- combined[sort(combined$V5, decreasing = TRUE), ]
View(combinedOrdered)

# Q4.
# OECD
mean(combined[combined$Income.Group=='High income: OECD',]$V2)
# non OECD
mean(combined[combined$Income.Group=='High income: nonOECD',]$V2)

# Q5.
# assign quentile values
quentile <- c(0.2,0.4,0.6,0.8,1)
q <- quantile(combined$V2, quentile)
q1 <- combined$V2 <= 38

xtabs(q1 ~ combined$Income.Group)