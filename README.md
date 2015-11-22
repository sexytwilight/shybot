# shybot

[![Join the chat at https://gitter.im/sexytwilight/shybot](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/sexytwilight/shybot?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
An adorable little Chat Bot for https://f-list.net/chat/

Install instructions:
requires Nodejs v5.0.0+ https://nodejs.org/en/

Copy `config.cson.example` and rename it something like `mybot.cson` just as long as it's a .cson file it should be fine. Open it up and edit the values so your bot can log into chat.
Make sure you `npm install` to install dependencies!
To run: `gulp --config mybot.cson`

all `*.cson` config files are `.gitignore` for you

Note: if Gulp4 has not released yet and you are having trouble, go to https://github.com/gulpjs/gulp/tree/4.0 Download ZIP and extract it to the `node_modules` folder of the bot, then rename the `gulp-4.0` to just `gulp` and then try to `npm install` again!
