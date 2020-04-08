# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@phone = Phone.create(number: '+5551992565774')
Patient.create(latitude: -30.017919, longitude: -51.135678, fever: true)

@phone = Phone.create(number: '+5551994765440')
Patient.create(latitude: -30.017636, longitude: -51.134417, cough: true)

@phone = Phone.create(number: '+5551991988447')
Patient.create(latitude: -30.010361, longitude: -51.135318, cough: true)

@phone = Phone.create(number: '+5551992778442')
Patient.create(latitude: -30.014644, longitude: -51.140382, headache: true)

@phone = Phone.create(number: '+5551998875566')
Patient.create(latitude: -30.014646, longitude: -51.14038, headache: true)
