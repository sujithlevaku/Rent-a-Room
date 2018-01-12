# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

role1 = Role.create(name: "guest") 
role2 =Role.create(name: "admin") 
role3 = Role.create(name: "host")

User.create(email: "admin@gmail.com",username:"admin",first_name:"admin",last_name:"admin",password:"sujith",mobile:"919912343257",role_id: 2)