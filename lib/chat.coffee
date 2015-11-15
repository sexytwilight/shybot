config = require '../config.coffee'

module.exports = ->
  messages = [
    "/me [eicon]flutterhide[/eicon] hides away from #{@character}.."
    "/me [eicon]fluttersad[/eicon] whimpers.. #{@character} is making her want to cry.."
    "/me [eicon]flutterohgoodness[/eicon] doesn't really know what to do about #{@character}.."
    "/me [eicon]flutterlurk[/eicon] slowly slinks away from #{@character}.."
    "/me [eicon]flutterohdear[/eicon] thinks #{@character} might have said a bad word.."
    "/me [eicon]flutterpoker[/eicon] pretends to know what #{@character} is talking about.."
    "/me [eicon]flutterisnotamused[/eicon] doesn't know what #{@character} mean.."
    "/me [eicon]flutteromnom[/eicon] listens while #{@character} is talking about her.."
    "/me [eicon]flutterisatree[/eicon] is a tree.. trees do not understand #{@character}'s words."
    "/me [eicon]flutterhmm[/eicon] deeply ponders what #{@character} has said."
    "/me [eicon]flutterblush[/eicon] blushes because of what #{@character} said about her."
    "/me [eicon]flutterflustered[/eicon] is flustered by what #{@character} said about her."
    "/me [eicon]flutterhuff[/eicon] isn't taking any more of #{@character}'s words."
    "/me [eicon]flutterflip[/eicon] is so frustrated with #{@character}'s words that she flips a table over."
  ]
  messages[(Math.random() * (messages.length - 1)) | 0]
