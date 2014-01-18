module CategoriesHelper
	def list_categories(cat_id)
		@names = Category.pluck(:name)
		@names.each do |x|
			cat_id = Category.find_by(name: x)
			cat_id = cat_id.id
		end

	end
end
