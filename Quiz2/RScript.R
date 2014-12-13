library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", "f390d65c8d9e0284c819", "302bb2ce083dbc134f95888f0ceccec4a2e50b8c")
# store the credentials we got from github for our app in the myapp variable

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# go knock on github's door (which is located at oauth_endpoints("github")) and show our credentials (myapp). They give us a token that we store in the variable github_token

# 4. Use API
gtoken <- config(token = github_token)
# before we go on and request information we need to wrap the token we just got in a new variable using the config function so we can show the server we already got our pass when requesting information
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
# finally we ask github about what we came for; we should replace this url with the url we are interested in, in our case where the info about Jeff Leek's repositories is located; the response we got is stored in the req variable and in this case it will come in the JSON format

stop_for_status(req)
# let's just make sure everything went right

content(req)
#Now we can check what response github gave us checking the content of the req variable and trying to make sense of that JSON thing they sent back

# OR:
# req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
# stop_for_status(req)
# content(req)
