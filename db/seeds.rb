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
puts 'Destroying all data'
Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all

# GENERATE INGREDIENTS
puts 'Generating list of Ingredients'
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
puts 'Get Drink ids'
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
list_cocktials = open(url).read
result = JSON.parse(list_cocktials)
drink_ids =[]
result['drinks'].each do |item|
  drink_ids << item['idDrink']  
end

# CREATE COCKTAILS
puts 'Create Cocktails'
drink_ids.each do |id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
  cocktail_details = open(url).read
  result = JSON.parse(cocktail_details)

  cocktail = Cocktail.create(name: result['drinks'][0]['strDrink'], picture_url: result['drinks'][0]['strDrinkThumb'])
  
  ingredients = Ingredient.all
  ingredients_hash = {}

  ingredients.each do |ingredient|
    n = 0
    15.times do
      n += 1
      if ingredient['name'] == result['drinks'][0]["strIngredient#{n}"]
        ingredients_hash[ingredient['id']] = result['drinks'][0]["strMeasure#{n}"] # key = ingredient id; value = dose description
      end
    end
  end

  ingredients_hash.each do |key, value|
    Dose.create(
      description: value,
      cocktail_id: cocktail.id,
      ingredient_id: key
    )
  end
end
puts 'Finished!'
