module.exports =
  'Turn On': ->
    "[eicon]flutterblush[/eicon] I've been turned on by #{@character}, oh my..."
  'Turn Off': ->
    "[eicon]flutterlurk[/eicon] I've been turned off by #{@character}"
  'Is Op?': (who) ->
    if @isOp @channel, who
      "/me thinks #{who} is an op!"
    else
      "/me does not think #{who} is an op...."
