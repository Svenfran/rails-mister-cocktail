# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'json'
require 'open-uri'
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# DESTROY EXIXTING DATA

Ingredient.destroy_all
# Cocktail.destroy_all

# GENERATE INGREDIENTS

Ingredient.create(name: "Lemon")
Ingredient.create(name: "Ice")
Ingredient.create(name: "Mint Leaves")
Ingredient.create(name: "Cream")


url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
list_ingredients = open(url).read
result = JSON.parse(list_ingredients)

result['drinks'].each do |item|
  Ingredient.create(name: item['strIngredient1']) 
end

# GET DRINK IDs

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
list_cocktials = open(url).read
result = JSON.parse(list_cocktials)
drink_ids =[]
result['drinks'].each do |item|
  drink_ids << item['idDrink']  
end

# CREATE COCKTAILS

drink_ids.each do |id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
  cocktail_details = open(url).read
  result = JSON.parse(cocktail_details)

  Cocktail.create(name: result['drinks'][0]['strDrink'])
  
  ingredients = Ingredient.all

end
# n = 1
#   15.times do
#     n += 1
#     p name = result['strDrink']
#     p ingredient = result["strIngredient#{n}"]
#     p dose = result["strMeasure#{n}"]
#   end