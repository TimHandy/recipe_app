require 'yaml/store' # Load the YAML::Store class

class RecipeStore

  def initialize(file_name)
    @store = YAML::Store.new(file_name)  # Create a store that reads/writes the given filename.
  end

  def find(id)
    @store.transaction do
      @store[id]
    end
  end

  def all
    @store.transaction do
      @store.roots.map { |id| @store[id] }
    end
  end

  # Save a recipe to the store
  def save(recipe)
    @store.transaction do  # Must be in a transaction...
      unless recipe.id  # If the recipe doesn't have an ID...
        highest_id = @store.roots.max || 0  # find the highest key
        recipe.id = highest_id + 1  # and increment it.
      end
      @store[recipe.id] = recipe  # Store the recipe under the key matching its ID
    end
  end

  # Delete a recipe from the store
  def delete(recipe)
    @store.transaction do
      @store.delete(recipe)
    end
  end

end
