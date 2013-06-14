fs = require 'fs'
parser = require 'xml2json'
mongo = require 'mongodb'
async = require 'async'
server = new mongo.Server 'localhost', 27017, {auto_reconnect:true}
db = new mongo.Db 'seao', server, {safe:true}


insert = ()->
  collection.insert avis, {safe:true}, (err, result) ->
    
importInDb = (fileName, collection, callback) ->
  fs.readFile fileName, (err, xml) ->
    console.log "Importing file: #{fileName}"
    #Synchronized json parser
    jsonData = parser.toJson xml
    jsonData = JSON.parse jsonData
    async.map jsonData.export.Avis, (avis, callback)->
      collection.insert avis, {safe:true}, (err, result)->
        if err then callback err
        else callback null, result
    , (err, results)->
      if err then callback err
      else callback null, results


console.log 'Starting mass import'
db.open (err, db) ->
  if err then console.log err
  db.collection 'avis', {safe:true}, (err, collection) ->
    #XXX Modify the list of files you wish to import
    fileList = [
      'avis-xml/20130611_093542.xml'
      'avis-xml/20130418_162106.xml'
      'avis-xml/20130418_164507.xml'
      'avis-xml/20130418_170416.xml'
      'avis-xml/20130426_165740.xml'
      'avis-xml/20130426_171053.xml'
      'avis-xml/20130426_171502.xml'
      'avis-xml/20130426_172417.xml'
      'avis-xml/20130502_120514.xml'
    ]
    async.map fileList, (file, callback)->
      importInDb file, collection, (err, results)->
        if err then callback err
        else
          console.log "Done importing file: #{file}"
          callback null, results
    , (err, results) ->
      if err then console.log "Error: #{err}"
      else console.log "Done importing all avis"
      db.close()
