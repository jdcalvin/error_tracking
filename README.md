ABOUT
=====

This application is intended for companies that do large scale production, and utilize qa/qc review of thier products, or with some modifications could easily be utilized as a survey application. For more information visit the applications [about page](http://afternoon-springs-2374.herokuapp.com/about)

Setup
-----

This applicaiton is currently configured to run on postgres. Ensure neccessary changes are made to `database.yml` before running `db:setup`.

Currently, `db/seeds.rb` is set up to randomly generate a number of `organizations`, `users`, `order_types`, and `orders` and will be organized into seperate rake files in a future update.

Usage
-----

More to come

* Devise configurations

* Creating/modifying templates

* Modifying validations