# frozen_string_literal: true

require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
counter = 0
str1_markerstring = 'ATK: '
str2_markerstring = 'DEF: '
str3_markerstring = ''
CSV.foreach('itemslist.csv') do |row|
  puts 'NEW CARD ---------------------'
  if row[4] != 'null'
    name = row[4]
    stats = row[5]

    if stats.count('Pendulum') > 0
      stats = stats.gsub('Pendulum Scales:', '')
      defence = stats.last(7)
      defence = defence.first(6)
    else
      defence = stats.last(4)
    end
    attack = stats[/#{str1_markerstring}(.*?)#{str2_markerstring}/m, 1]
    defence = defence.last(1) if defence.count('a-zA-Z') > 0
    defence = defence.gsub(/\s+/, '') if defence.count(' ') > 0
    description = row[6]
    card_type = row[7]
    puts name
    puts stats
    puts description
    puts card_type
    price = rand(1..40)
    price += 0.99

    # we can create the cards now with these variables
    Card.create(name: name, card_type: card_type, description: description, attack: attack.to_i, defence: defence.to_i, price: price)
    counter += 1
  end
end
puts counter
puts('END OF FILE SPLITTING')

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
