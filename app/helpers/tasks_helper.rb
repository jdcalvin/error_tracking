module TasksHelper
	def list_category
		Category.pluck(:id)
	end

	#def covert_to_id(&list_category)
	#	Category.find_by(name: list_category).id
	#end
end
