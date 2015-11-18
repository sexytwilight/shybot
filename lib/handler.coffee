module.exports = (name, handler) -> (error, args...) ->
  if error
    console.log "#{name} Error: #{error?.message or error}\n#{error?.stack}"
  else
    handler? args...
