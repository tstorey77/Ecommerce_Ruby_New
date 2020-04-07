# frozen_string_literal: true

require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ****** CREATING CATEGORIES **************
counter = 0
CSV.foreach('itemslist.csv') do |row|
  card_type = row[7]
  Category.create(name: card_type)
  counter += 1
end
puts counter

# ************** CREATING CARDS *****************************
counter = 0
str1_markerstring = 'ATK: '
str2_markerstring = 'DEF: '
str3_markerstring = ''

CSV.foreach('itemslist.csv') do |row|
  if row[4] != 'null'
    name = row[4]
    stats = row[5]

    # removing problems with pendulum cards
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
    price = rand(1..40)

    # get category
    category = Category.where(name: card_type)
    real_category = category.first
    puts category.first.name

    # create the card now
    card = real_category.cards.create(name: name, card_type: category.first.name, description: description, attack: attack.to_i, defence: defence.to_i, price: price)
    puts card.inspect
    counter += 1
  end
end

puts counter

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
