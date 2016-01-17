require 'yaml'
require 'pry'
require 'slim'



# Original working deserialize method
# def deserialize
# 	if File.exists?('lib/recipes.yml')
# 		recipes = []
# 		File.open( 'lib/recipes.yml' ) do |file|
# 			YAML::load_documents( file ) do |item|
# 		  	recipes << item
# 			end
# 		end
# 	end
# 	  # recipes.each do |recipe|
# 		# 	puts recipe.inspect
# 		# 	puts
# 		# end
# end


# original working Serialize to the yaml file.
# def serialize
# 	File.open( 'lib/recipes.yml', 'a' ) do |file|
# 		file.puts YAML::dump(self)
# 	end
# end


class Recipe
	attr_accessor :name, :ingredients, :instructions, :prep_time, :cook_time, :serves, :difficulty, :favorite, :healthy, :protein_source, :vegetarian, :date_added, :type, :comments, :id

	def initialize(name: "Unknown")
		self.name = name # used self. instead of @ to refer the code directly to the attr_accessor methods. This will still work if I create a manual attr_writer/reader method for validation purposes. This prevents duplication of code.
		self.date_added = Time.now
		self.healthy = true  # Most of our meals are healthy
		self.ingredients = "Ingredients here"
		self.instructions = "Instructions here"
		# TODO raise error when no name added
	end

	def print_recipe
		# TODO: This will need to output in html (it does now! it displays on the show.erb template), but not in this format. How to do that?
		# IDEA: could have this be the .to_s method?
		puts "Recipe:\t\t#{self.name.upcase}" 	# Don't actually need the self when referring to an instance method, it will default to self.
		#puts ingredients.split(",")
		total_time = prep_time + cook_time
		puts "Total Time:\t#{total_time} min"
		puts "Ingredients:"
		ingredients_arr = ingredients.split(", ")
		ingredients_arr.each do |ingredient|
			puts "\t\t#{ingredient.capitalize}"
		end
		puts "Instructions:"
		puts "\t\t#{instructions.capitalize}"
		puts
		puts
	end


end

class MainCourse < Recipe

	attr_accessor :protein_source

	def initialize
		super
	end

end

# do i need this? for a category maybe? or just have this as an attribute?
class Dessert < Recipe

	def initialize
		super
	end

end

# do i need this? for a category maybe? or just have this as an attribute?
class SideDish < Recipe

		def initialize
			super
		end

end

# Output an array of vegetarian recipes
def vege_recipes(recipes)
	vege_recipes = []
	recipes.each do |recipe|
		if recipe.vegetarian == true
			vege_recipes << recipe
		end
	end
	vege_recipes
end


# Generate 6 random recipes for the week
def six_random_recipes(recipes_arr)
	six_random_recipes = []
	6.times do
		six_random_recipes << recipes_arr.shuffle!.pop
	end
	six_random_recipes
end

# IDEA: Generate a shopping list from the ingredients list
def grocery_list
	self.each do |recipe|
		puts recipe.name
		puts recipe.ingredients
	end
end

# IDEA: Generate 6 random recipes that don't have garlic? or just omit the garlic when you make it?

# IDEA: Search for non-garlic... tick box
# List those where ingredients !include('garlic')
def non_garlic(recipes_arr)
	non_garlic_arr = []
	recipes_arr.each do |recipe|
		unless recipe.ingredients.downcase.include?( 'garlic' )
			non_garlic_arr << recipe
		end
	end
	non_garlic_arr
end

# Pick a random dinner
def random_recipe(recipes_arr)
	recipes_arr.shuffle.pop
end


# List recipes containing the word/s x in name
def name_contains(recipes_arr, name_contains)
	temp_array = []
	recipes_arr.each do |recipe|
		if recipe.name.downcase.include?( name_contains )
			temp_array << recipe
		end
	end
	temp_array
end

# TODO: Generate a week's worth of meals, include 2 fish and 1 red meat, must contain a Tim's favorite. Send to text file? Screen?

# TODO: Category: will be classes?

# Random favorite
def favorite(recipes_arr)
	favorite = []
	recipes_arr.each do |recipe|
		if recipe.favorite == true
			favorite << recipe
		end
	end
	favorite.sample
end

# IDEA: Pick a dinner containing the word/s x in ingredients

# IDEA: If weekend allow not healthy in selecting/generating meals



# Run stuff after here: ==================================================

# recipes = deserialize  # this has to be down here because it complains about not knowing what a MainCourse is if it's at the top.



# print each recipe name from the array
# recipes.each do |item|
# 	puts item.name
# end

# print the whole list of recipes
# recipes.each do |item|
# 	item.print_recipe
# end




# Print the name of the Vegetarian recipes
# puts "Vege recipes:"
# vege_recipes(recipes).each { |item| puts item.name }

# Print the vege recipes
# vege_recipes(recipes).each { |item| item.print_recipe}

# Print 6 random recipes
# six_random_recipes(recipes).each do |item|
# 	puts item.print_recipe
# end


# Print a random favorite
# puts favorite(recipes).print_recipe

# Print name_contains recipes
# name_contains(recipes, "pasta").each do |item|
# 	puts item.name.upcase
# end



# recipe = MainCourse.new(name: "Joylent")
# recipe.ingredients = "meat stuff 100g, Flour 200ml, Eggs x3"
# recipe.protein_source = "Whey"
# recipe.prep_time = 5
# recipe.cook_time = 25
# recipe.instructions = "This is how we do it.... , then we do the other, and now it's done!"
# recipe.print_recipe
# recipe.serialize


# IDEA: Display recipes containing >= 1 of a list of ingredients entered, in order of most ingredients found
