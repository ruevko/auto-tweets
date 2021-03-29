if (file.exists("resources/credentials.txt")) {
   creds = readLines("resources/credentials.txt")
} else creds = commandArgs(TRUE)

if (length(creds) != 5) stop("Credentials in wrong amount or unavailable")

if (dir.exists("resources/library")) .libPaths("resources/library")

library("rtweet")

token = create_token(creds[1], creds[2], creds[3], creds[4], creds[5], set_renv = FALSE)

if (file.exists("new_status.txt")) {
   readLines("new_status.txt") %>% paste(collapse = "\n") %>% post_tweet(token = token)
} else post_tweet(token = token)
