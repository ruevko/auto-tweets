stopifnot(file.exists("credentials.txt"))

library(twitteR)

credentials = readLines("credentials.txt")

options(httr_oauth_cache = FALSE)

setup_twitter_oauth(credentials[1],
                    credentials[2],
                    credentials[3],
                    credentials[4])

newstatus = ifelse(file.exists("newstatus.txt"),
                   paste(readLines("newstatus.txt"), collapse = "\n"),
                   "This is my default\n#TwitterAPI test\n\u2728\u2728\u2728")

newstatus = updateStatus(newstatus)

Sys.sleep(30)

delstatus = deleteStatus(newstatus)

if(delstatus) message("Success \u270C")
