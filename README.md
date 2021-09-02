## Automatic Tweets :computer: :arrow_right: :bird:

I created this repository in order to learn how to use [GitHub Actions](https://github.com/features/actions) in conjunction with the [Twitter API](https://developer.twitter.com/en).

### Manual Workflow [![Manual Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/manual.yml/badge.svg)](https://github.com/ruevko/auto-tweets/actions/workflows/manual.yml)

This workflow uses the [Send Tweet Action](https://github.com/marketplace/actions/send-tweet-action) to post a tweet (defined by the `status` input) and can be executed with GitHub or its API.

### Daily Workflow [![Daily Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/daily.yml/badge.svg?event=schedule)](https://github.com/ruevko/auto-tweets/actions/workflows/daily.yml)

This workflow also uses [Send Tweet Action](https://github.com/marketplace/actions/send-tweet-action) but it posts a tweet everyday, using either the content of `today_status.txt` or a timestamp. This one isn't particularly useful.

### Manual rtweet Workflow [![Manual rtweet Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/manual_rtweet.yml/badge.svg?event=workflow_dispatch)](https://github.com/ruevko/auto-tweets/actions/workflows/manual_rtweet.yml)

This is like Manual Workflow, but using the [rtweet](https://docs.ropensci.org/rtweet/) R package. The `status` input is optional: if unavailable, rtweet posts a default status.

### Daily RSS Workflow [![Daily RSS Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/daily_rtweet_rss.yml/badge.svg?branch=main&event=schedule)](https://github.com/ruevko/auto-tweets/actions/workflows/daily_rtweet_rss.yml)

The useful one. It checks a RSS feed on a daily basis, and tweets if a new blog post is discovered (uses the [rtweet](https://docs.ropensci.org/rtweet/) and [xml2](https://xml2.r-lib.org/) packages). Check `rtweet_rss.R` for instructions on how to define the RSS feed.
