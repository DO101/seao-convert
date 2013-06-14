mongo = require 'mongodb'

server = new mongo.Server 'localhost', 27017, {auto_reconnect:true}
db = new mongo.Db 'seao', server

console.log "création de la collection d'avis seao"

db.open (err, db)->
  if err then console.log err
  db.createCollection 'avis', {safe:true}, (err, collection) ->
    if err
      console.log err
      db.close()
    db.close()

console.log "done!"
