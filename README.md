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
A json dump for mongoDB is available at : XXX

You can import it using [mongoimport](http://docs.mongodb.org/manual/reference/program/mongoimport/)

future work
==========
I'm converting the database into an easy to use CVS so that the data can be more accessible.
