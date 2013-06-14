seao-convert
============

Project to convert data from SEAO into more usable formats. This first version just reads all the XML files, converts them to JSON and dumps them in a mongoDB instance. 


requirements
===========
* [nodejs](http://nodejs.org/)
* [mongoDB](http://www.mongodb.org/)
* the seao data sources available [here](http://donnees.gouv.qc.ca/?node=/donnees-details&id=542483bf-3ea2-4074-b33c-34828f783995#meta_telechargement)

install
===========
Copy the data sources, unzipped in the avis-xml folder then:

    npm install

    coffee createCollectionAvis.coffee
    coffee import.coffee

extra
===========
A json dump for mongoDB is available [here](http://pages.clibre.uqam.ca/seao/avis.json.gz)
You can import it using [mongoimport](http://docs.mongodb.org/manual/reference/program/mongoimport/)

csv
==========
A csv dump is available [here](http://pages.clibre.uqam.ca/seao/avis.csv.gz)

In order to reproduce this file, make sure you have imported your data in your mongoDB using the import.coffee script, and then run:
    coffee convertCSV.coffee >avis.csv

The script produces the CSV in the standard input, so you can just redirect it to some file.

Since there are nested objects (fournisseurs.fournisseur), I decided to duplicate lines in order to flatten the structure. So for one avis, you have one line per fournisseur.


