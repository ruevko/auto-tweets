if (file.exists("resources/credentials.txt")) {
   creds = readLines("resources/credentials.txt")
} else creds = commandArgs(TRUE)

if (length(creds) != 5) stop("Credentials in wrong amount or unavailable")

rss_url = NULL # a RSS feed URL, if NULL it will use a modified version of https://xmin.yihui.org/index.xml
use_titles = FALSE # by default RSS item's descriptions are tweeted, set this to TRUE to tweet titles instead
time_format = "%a, %d %b %Y %T %z" # RSS pubDate format, the default is like Sun, 07 Jan 1979 14:28:56 -0500
tweet_start = "New Blog Post:" # a message to start every tweet with
tweet_limit = 187 # max number of characters to tweet, must be between 100 and 280

if (tweet_limit < 100 | tweet_limit > 280) {
   stop("That tweet_limit won't work!")
} else tweet_limit = tweet_limit - nchar(tweet_start) - 3

rss = if (is.null(rss_url)) read_xml("yihui-xmin-rss.xml") else GET(rss_url) |> content(encoding = "UTF-8")

if (dir.exists("resources/library")) .libPaths("resources/library")

message("Using ", R.version.string)
library("httr"); message("and httr version ", packageVersion("httr"))
library("xml2"); message("and  xml2 version ", packageVersion("xml2"))
library("rtweet"); message("and rtweet version ", packageVersion("rtweet"))

rss_times = xml_find_all(rss, "channel/item/pubDate") |> xml_text() |> as.POSIXct(format = time_format)
# for a RSS item to be tweeted, its pubDate must be within the last day, past and future items are ignored
# the GitHub Actions execution time may differ a little each day, but this approach should be good enough
rss_is_new = rss_times < Sys.time() & rss_times > Sys.time() - 86400

if (!any(rss_is_new)) message("No new POSTS to tweet.\nKeep up the good work!") else {
   message("Found ", sum(rss_is_new), " new POST", if(sum(rss_is_new) > 1) "S", " to tweet!")
   token = create_token(creds[1], creds[2], creds[3], creds[4], creds[5], set_renv = FALSE) # DEPRECATED

   rss_titles = xml_find_all(rss, "channel/item/title") |> xml_text()
   rss_descs = xml_find_all(rss, "channel/item/description") |> xml_text()
   rss_links = xml_find_all(rss, "channel/item/link") |> xml_text()

   for (i in which(rss_is_new)) {
      message("For POST", i, ": ", rss_titles[i]); tweet_link = rss_links[i]
      tweet = gsub("</?p>", "", if (use_titles) rss_titles[i] else rss_descs[i])

      while (grepl("<\\w+>([^<]+)</\\w+>", tweet)) {
         hashtag = sub("[^<]*<\\w+>([^<]+)</\\w+>.*", "\\1", tweet)
         hashtag = gsub("\\s(.{1})", "\\U\\1", hashtag, perl = TRUE)
         tweet = sub("<\\w+>([^<]+)</\\w+>", paste0("#", hashtag), tweet)
      }

      while (nchar(tweet) > tweet_limit - nchar(tweet_link)) tweet = sub("\\s+\\S*$", "[...]", tweet)

      paste(tweet_start, tweet, tweet_link, sep = "\n") |> post_tweet(token = token)
      if (i != max(which(rss_is_new))) Sys.sleep(3)
   }
}
