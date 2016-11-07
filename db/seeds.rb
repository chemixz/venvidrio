# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: "m3taljose@gmail.com", password: "12345678", password_confirmation: "12345678" , full_name: "José Migue" , full_last_name: "Briceño Garcés", credential: 181818 , role: 3 )
User.create(email: "io.perez.robert@gmail.com", password: "12345678", password_confirmation: "12345678"  , full_name: "Robert Anthony " , full_last_name: "Pérez Araujo", credential: 797 , role: 2 )
User.create(email: "io.perez.robert@hotmail.com", password: "12345678", password_confirmation: "12345678"  , full_name: "Robert Anthony " , full_last_name: "Pérez Araujo", credential: 797 , role: 3 )