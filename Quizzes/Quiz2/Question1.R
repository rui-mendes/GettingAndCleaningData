# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Rui Mendes
# ruidanielalvesmendes@gmail.com

# copied from H. Wickham

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#

#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", key="f390d65c8d9e0284c819", secret="302bb2ce083dbc134f95888f0ceccec4a2e50b8c")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos")
stop_for_status(req)
a <- content(req)

# answer: 2013-11-07T13:25:07Z