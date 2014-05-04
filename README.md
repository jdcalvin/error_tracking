ABOUT
=====

This is an example enterprise level application built with rails. It is intended for companies that do large scale production, and utilize qa/qc review of thier products, or with some modifications could easily be utilized as a survey application. For more information visit the applications [about page](http://afternoon-springs-2374.herokuapp.com/about)

Setup
-----

This applicaiton is currently configured to run on postgres. Ensure neccessary changes are made to `database.yml` before running `db:setup`.

Ruuning `db/seeds.rb` will generate a set of organizations with users and activity. Rake tasks are currently being written to create customized data sets for demoing.
