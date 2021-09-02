## Automatic Tweets :computer: :arrow_right: :bird:

I created this repository in order to learn how to use [GitHub Actions](https://github.com/features/actions) in conjunction with the [Twitter API](https://developer.twitter.com/en).

### Manual Workflow [![Manual Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/manual.yml/badge.svg)](https://github.com/ruevko/auto-tweets/actions/workflows/manual.yml)

This workflow uses the [Send Tweet Action](https://github.com/marketplace/actions/send-tweet-action) to post a tweet (defined by the `status` input) and can be executed with GitHub or its API.

### Daily Workflow [![Daily Workflow](https://github.com/ruevko/auto-tweets/actions/workflows/daily.yml/badge.svg?event=schedule)](https://github.com/ruevko/auto-tweets/actions/workflows/daily.yml)

This workflow also uses [Send Tweet Action](https://github.com/marketplace/actions/send-tweet-action) but it posts a tweet everyday, using either the content of `today_status.txt` or a timestamp. This one isn't particularly useful.
