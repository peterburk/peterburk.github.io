# NanoLyrics

## About

- Do you want to write a love letter in another language?
- Need to make another cheesy pop song?
- Create a mixtape and a romantic letter in one?

You probably don't need NanoLyrics! But Valentine's Day is coming up, and if you're tongue-tied, it'll help you gain inspiration about what to write, using song lyrics. 

NanoLyrics is not AI, or even "big data". It's not going to use word2vec to be a real chatbot. 
It's "small data": carefully curated data for a specific purpose. 

## How to use it

- Go to the [NanoLyrics](https://peterburk.github.io/programs/nanoLyrics/nanoLyrics.html) page. 
- Type a word in the search box. 
- Click the search button. 
- Scroll through the sentences that include that word in the results area on the right. 
- Click once on the sentence you like, and it will be copied into the text area on the left. 
- Repeat and edit until you've finished writing the love letter!

## Which songs are included?

There's a few options, and you can load a new dataset by clicking a button. 
- Chinese is a collection of bilingual English/Chinese worship music. 
- Boyzone is my girlfriend's favourite band. 
- [Diane Warren](https://en.wikipedia.org/wiki/Diane_Warren) is a prolific song writer of cheesy pop music. I didn't just include her 32 top 10 songs, but all songs from the [List of songs written By Diane Warren](https://en.wikipedia.org/wiki/List_of_songs_written_by_Diane_Warren) on Wikipedia. 
- Peter is the lyrics of most of the music in my playlist, mostly punk rock. 

## I don't know what to search for.

Check out some word clouds to see the most common words. 

![dianeWarrenWordCloud](https://raw.githubusercontent.com/peterburk/peterburk.github.io/master/programs/nanoLyrics/dianeWarrenWordCloud.png "Diane Warren word cloud")

![boyzoneWordCloud](https://raw.githubusercontent.com/peterburk/peterburk.github.io/master/programs/nanoLyrics/boyzoneWordCloud.png "Boyzone word cloud")


A simple love letter can have whatever structure you want! How about this:
You, think, miss, us, together, dream, hope, love. 

## Did you spoil the surprise by putting this online?

Yes, and my girlfriend thought it was cheesy, but she didn't mind. 
I couldn't keep it secret while coding it. As a non-native English speaker, she's actually my target user, so I appreciated the feedback. 

## Can I run it offline?

Yes! Download the [Fondant PDF](https://peterburk.github.io/programs/nanoLyrics/boyzoneChat.pdf) version. 
Then open the PDF in Google Chrome. Right click the link, and it will show an "choose file" link. 
Choose the same PDF file that you just saved. The web app will be loaded in your browser locally. 
This is using a method I call "Fondant", using PDF attachments to wrap up Vanilla JS apps in a single file. 
I'll write more about Fondant and post it on Hacker News sooner or later. 

## Why the name?
Nano is a command-line text editor, and this includes a basic textarea. 
It would be nice to actually make it a command-line app too, but I'd rather launch it first as a demo that runs online. 

## The user interface sucks. 
I know, but I honestly don't know how to make it look pretty. Implementing the CSS is the easy part, but I don't know why buttons have to be blue/orange/etc. Serious question: how can I learn to make pretty things? 
