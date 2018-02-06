# Reddit Bot

An example bot for my [talk](https://github.com/jasonwc/i-for-one-welcome-our-new-robot-overlords) at the Downtown Utah Ruby User Group

The bot responds to `@reddit-bot reddit :subreddit [:hot|:new|:top|:rising|:controversial]`

## Instructions
- Checkout `master` if you want to have boiler plate and create your own commands.
- Checkout `1-fetching` if you want to see the bot grabbing things from /r/all
- Checkout `2-subreddits` if you want to see the bot grabbing things from a particular subreddit
- Checkout `3-sorting` if you want to see the bot sorting posts
- Checkout `4-formatting` if you want to see the bot formatting the messages for slack 

## Quick Start

This bot assumes you have [RVM](https://rvm.io/) installed. If you don't, its simple!

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
```

Once you've installed rvm and installed the correct Ruby, run the following

```
git clone git@github.com:jasonwc/reddit-bot-example.git
cd reddit-bot-example
bundle install
cp .env.sample .env
# Get a Bot token from Slack and add it to you .env file
ruby run.rb
```
