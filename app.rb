require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/course")
require("pg")

DB = PG.connect({:dbname => "registrar"})