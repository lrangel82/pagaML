# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Status.create(name: "Open")
Status.create(name: "Paid")
Status.create(name: "Prepaid")
Status.create(name: "Cancel")
Status.create(name: "Close")
Status.create(name: "Defaulter")

Moneylender.create(alias:"L", clabe:"123456789012345", account_number: 7436278982, bank: "PATITO")