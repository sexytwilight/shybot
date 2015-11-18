# Feature request by https://www.f-list.net/c/trixie/
module.exports = ->
  messages = [
    "/me [eicon]flutterlurk[/eicon] suggests that #{@character} praises Trixie.."
    "/me [eicon]flutterohdear[/eicon] thinks #{@character} is a non believer for the Great And Powerful Trixie.."
    "/me [eicon]flutterpoker[/eicon] HANDS OUT TRIXIE BELIEVER POSTERS!.. to #{@character}"
    "/me [eicon]flutterisnotamused[/eicon] urges #{@character} to worship Trixie, like they should.."
    "/me [eicon]flutteromnom[/eicon] listens while #{@character} is about to surgically implanted with a Trixie worshipping pill."
  ]
  messages[(Math.random() * (messages.length - 1)) | 0]
