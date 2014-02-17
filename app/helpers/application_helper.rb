module ApplicationHelper
	def link_to_add_fields(name, x, association) #"Add Category", x (object instance, ie f = order_type, c = category, t =task), association = :categories, :tasks
		new_object = x.object.send(association).klass.new #Creates empty instnace of :categories/:tasks
		id = new_object.object_id
		fields = x.fields_for(association, new_object, child_index: id)
		link_to(name, '#', class: "add_#{association.to_s}", data: {id: id, fields: fields.gsub("\n", "")})
	end

end
