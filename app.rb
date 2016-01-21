require 'sinatra'
require 'shotgun'
require 'recipe'
require 'recipe_store'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'pry'

store = RecipeStore.new('recipes.yml')

get ('/') do
	redirect '/recipes'
end

# Display all recipes route
get('/recipes') do
	@title = "All My Recipes"
	@recipes = store.all
	slim :index
end

# TODO: Do I need this route at all?
get('/recipes/new') do
	@title = "Create A New Recipe"
	@recipe = Recipe.new  # From a slightly different guide: "This simply creates a new recipe object and stores it in the instance variable @recipe, which will be available in the view. We probably won’t need this object at the moment, but in the future we might be using the same form to edit a page as we do to create a new one. The edit form will have references to the recipe that is being edited, which will be the @recipe instance variable. If this didn’t exist then we’d get errors, so we just create a new Recipe object to avoid this."
	slim :new
end

# Create new recipe post route
post('/recipes/create') do
	 #"Received: #{params.inspect}"  # for testing purposes
	@recipe = Recipe.new
	@recipe.name = params['title'].split(/(\W)/).map(&:capitalize).join # only way to convert to titlecase
	@recipe.type = params['type'].capitalize
	@recipe.serves = params['serves']
	@recipe.protein_source = params['protein_source'].capitalize
	@recipe.prep_time = params['prep_time']
	@recipe.cook_time = params['cook_time']
	@recipe.ingredients = params['ingredients'].capitalize
	@recipe.instructions = params['instructions'].capitalize
	@recipe.comments = params['comments'].capitalize
	store.save(@recipe)
	redirect '/recipes/new'
end

get('/recipes/:id') do
  id = params['id'].to_i
  @recipe = store.find(id)
	@ingredients_arr = @recipe.ingredients.split(", ")
  slim :show
end

# TODO: # edit save a recipe. Can I do this just with the /recipes/create route?
# TODO: should this route be /recipe/:id/update ? seems bad just being /recipes/:id. will need to update the view also.
# Update recipe route
put '/recipes/:id' do
  id = params['id'].to_i
	@recipe = store.find(id)

	# @recipe = Recipe.new # this was causing edits to create a new recipe rather than editing.
	@recipe.name = params['title'].split(/(\W)/).map(&:capitalize).join # only way to convert to titlecase
	@recipe.type = params['type'].capitalize
	@recipe.serves = params['serves']
	@recipe.protein_source = params['protein_source'].capitalize
	@recipe.prep_time = params['prep_time']
	@recipe.cook_time = params['cook_time']
	@recipe.ingredients = params['ingredients'].capitalize
	@recipe.instructions = params['instructions'].capitalize
	@recipe.comments = params['comments'].capitalize
	store.save(@recipe)
	redirect "/recipes/#{@recipe.id}"
end

# Edit recipe get route
get '/recipes/:id/edit' do
	id = params['id'].to_i
	@recipe = store.find(id)
	@title = "Edit Recipe: #{@recipe.name}"
	slim :edit
end

# Get route for deleting a recipe
get '/recipes/:id/delete' do
	id = params['id'].to_i
	@recipe = store.find(id)
	@title = "Confirm deletion of recipe"
	if @recipe
	  slim :delete
	else
	  redirect '/', :error => "Can't find that recipe."
	end
end

# TODO: flash notices not working. Should work with the if flash section on the layout.erb. Might be the lack of css?
# Delete a recipe
delete '/:id' do
	id = params['id'].to_i
	if store.delete(id)
    redirect '/', :notice => "Recipe deleted successfully."
  else
    redirect '/', :error => "Error deleting recipe."
  end
end

# TODO: option to export all recipes to csv.
# TODO: add some bootstrap formatting
