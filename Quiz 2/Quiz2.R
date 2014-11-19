######## Question 1 ########

library(httr)
oauth_endpoints("github")

myapp <- oauth_app("github", "ClientID", "ClientSecret")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))


######## Question 2 ########
library(sqldf)
acs <- download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "acs.csv")
acs <- read.csv("acs.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")


######## Question 3 ########
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


######## Question 4 ########
fUrl <- "http://biostat.jhsph.edu/~jleek/contact.html" 
fUrl <- url(fUrl)
htmlCode <- readLines(fUrl)
close(fUrl)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)


######## Question 5 ########
data <- download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", "data.for")
data <- read.csv("data.for", header=T)
df <- read.fwf(file="data.for", widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(df[, 4])
