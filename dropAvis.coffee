mongo = require 'mongodb'

server = new mongo.Server 'localhost', 27017, {auto_reconnect:true}
db = new mongo.Db 'seao', server

console.log "drop collection avis"

db.open (err, db)->
  if err then console.log err
  db.dropCollection 'avis', (err, collection) ->
    if err
      console.log err
      db.close()
    db.close()

