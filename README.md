# Kate's Morning Sunshine Program

This is a little program I have on my laptop that I have set (with a launchd script) to run every morning. It goes out and gathers the forecast, my calendar, my latest emails and displays my Workflowy. I love it! I took out a lot of the good stuff from this program (this stuff that fetches my email and displays my calendar) but you can see how the rest of it works.

(Don't know [Workflowy](https://workflowy.com/invite/3132e46.lnx)? Check it out - I _literally_ wouldn't get anything done without it! If you sign up through my link you get twice the space!)

Looks like this:

![Morning Sunshine](/img/screenshot.jpg)

A fun little Ruby program to start the day off right!

## How it works

I have a launchd script that runs a shell script every morning. That shell script runs my ruby script, like this: 

```
#!/bin/bash
 
ruby lib/morning_page.rb
```

Then the ruby script gets all of its info from RSS feeds, etc, and populates `index.html` with the info and then opens my nice html page. 