# Run from commandline with 'ruby -I lib yaml_test.rb'

require 'recipe'
require 'yaml/store'

store = YAML::Store.new('yaml_test.yml')

first_recipe = Recipe.new
first_recipe.recipe_name = "Banana pie"
first_recipe.instructions = "Bake pie"
first_recipe.prep_time = 20

second_recipe = Recipe.new
second_recipe.recipe_name = "sausage mash"
second_recipe.instructions = "mash tatties, cook sausages"
second_recipe.prep_time = 5

store.transaction do
  store["Banana pie"] = first_recipe
  store["Sausage mash"] = second_recipe
  p store["Banana pie"]
end
