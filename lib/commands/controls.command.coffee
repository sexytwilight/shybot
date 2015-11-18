module.exports =
  on: (args...) ->
    console.log "!ON #{@character} #{@message} #{args}"
    "[eicon]flutterblush[/eicon] I've been turned on by #{@character}, oh my..."
  off: (args...) ->
    console.log "!OFF #{@character} #{@message} #{args}"
    "[eicon]flutterlurk[/eicon] I've been turned off by #{@character}"
