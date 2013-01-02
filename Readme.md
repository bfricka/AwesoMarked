# AwesoMarked

AwesoMarked is just another Markdown app.  I am creating it because I purchased the nicely done [Marked App](http://markedapp.com/), and while I enjoyed it at first, I found a number of things that I disliked about it.

### Background & Motivation

These things were the problems that I set out to solve with AwesoMarked. Here are a few of them:

- While you can generally connect an adapter, the feedback still isn't instant.  I decided AngularJS would be a perfect way to remedy that.

- Marked has a fatal flaw where too many fenced code blocks will absolutely destroy performance.  There is a certain threshold where rendering crawls to a standstill using the default renderer.

- Marked is not extensible or customizable to the level I want it to be.

The major flaw with Marked is it's terrible rendering performance.  This was easy enough to solve using the spectacular (although in this case, confusingly named) [Marked](https://github.com/chjj/marked) Node.js renderer. This blazingly fast render, is a drop-in replacement for the default Marked renderer using the `--gfm` and `--sanitize` flags.

So if you have the Marked OS X app, and you just want it to work better, give that engine a try.

However, I realized through this that I could still get more of what I wanted by writing something myself. Plus, it would be fun!

Using spectacular open source tools, I hope to make AwesoMarked everything that Marked is, and so much more.

### Disclaimer

This thing is totally a work-in-progress.  Even my todo list was just created.

If you somehow stumble on this thing, and you're decent with AngularJS and CoffeeScript, feel free to lend a hand.

-Brian