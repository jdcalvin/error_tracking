module CategoriesHelper
	def list_categories
		options_from_collection_for_select(Category.all, :id, :name)
	end
end
