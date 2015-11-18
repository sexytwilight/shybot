cd %~dp0
mkdir commands
mkdir interactions
mkdir plugins
git init
git remote add origin https://github.com/sexytwilight/shybot.git
git pull
npm update --production & pause
