library(twitteR)

credentials = readLines("credentials.txt")

options(httr_oauth_cache = FALSE)

setup_twitter_oauth(credentials[1],
                    credentials[2],
                    credentials[3],
                    credentials[4])

test = updateStatus("This is a\nTwitter #API test\n\u270C")

deleteStatus(test)
