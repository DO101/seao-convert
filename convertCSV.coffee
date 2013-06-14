fs = require 'fs'
mongo = require 'mongodb'
async = require 'async'
server = new mongo.Server 'localhost', 27017, {auto_reconnect:true}
db = new mongo.Db 'seao', server, {safe:true}
json2csv = require 'json2csv'
_ = require 'underscore'

db.open (err, db) ->
  if err then console.log err
  db.collection 'avis', {safe:true}, (err, collection) ->
    collection.find({}).toArray (err, allAvis)->
      if err then console.log err
      else
        if allAvis
          async.map allAvis, (avis, callback) ->
            async.map avis.fournisseurs.fournisseur, (fournisseur, callback)->
              avisFournisseur =
                numeroseao: avis.numeroseao
                numero: avis.numero
                organisme: avis.organisme
                municipal: avis.municipal
                adresse1: avis.adresse1
                adresse2: avis.adresse2
                province: avis.province
                pays: avis.pays
                codepostal: avis.codepostal
                type: avis.type
                nature: avis.nature
                precision: avis.precision
                datepublication: avis.datepublication
                datefermeture: avis.datefermeture
                datesaisieadjudication: avis.datesaisieadjudication
                dateadjudication: avis.dateadjudication
                regionlivraison: avis.regionlivraison
                unspscprincipale: avis.unspscprincipale
                disposition: avis.disposition
                fournisseur_nomorganisation: fournisseur.nomorganisation
                fournisseur_adresse1: fournisseur.adresse1
                fournisseur_adresse2: fournisseur.adresse2
                fournisseur_ville: fournisseur.ville
                fournisseur_province: fournisseur.province
                fournisseur_pays: fournisseur.pays
                fournisseur_codepostal: fournisseur.codepostal
                fournisseur_admissible: fournisseur.admissible
                fournisseur_conforme: fournisseur.conforme
                fournisseur_adjudicataire: fournisseur.adjudicataire
                fournisseur_montantsoumis: fournisseur.montantsoumis
                fournisseur_montantssoumisunite: fournisseur.montantssoumisunite
                fournisseur_montantcontrat: fournisseur.montantcontrat
              callback null, avisFournisseur
            , (err, results)->
              if err then console.log err
              callback null, results
          , (err, results)->
            if err then console.log err
            cols = [
              "numeroseao"
              "numero"
              "organisme"
              "municipal"
              "adresse1"
              "adresse2"
              "province"
              "pays"
              "codepostal"
              "type"
              "nature"
              "precision"
              "datepublication"
              "datefermeture"
              "datesaisieadjudication"
              "dateadjudication"
              "regionlivraison"
              "unspscprincipale"
              "disposition"
              "fournisseur_nomorganisation"
              "fournisseur_adresse1"
              "fournisseur_adresse2"
              "fournisseur_ville"
              "fournisseur_province"
              "fournisseur_pays"
              "fournisseur_codepostal"
              "fournisseur_admissible"
              "fournisseur_conforme"
              "fournisseur_adjudicataire"
              "fournisseur_montantsoumis"
              "fournisseur_montantssoumisunite"
              "fournisseur_montantcontrat"
            ]
            avisFournisseurs = _.flatten results
            if avisFournisseurs.length > 0
              json2csv {data:avisFournisseurs, fields:cols}, (err, csv) ->
                console.log csv
      db.close()
