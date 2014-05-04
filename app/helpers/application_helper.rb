module ApplicationHelper
	def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def alert_icons
		hash = Hash.new(0)
		hash[:success] = "ok-sign"
		hash[:info] = "info-sign"
		hash[:warning] = "exclamation-sign"
		hash[:danger] = "exclamation-sign"
		return hash
	end

  def destroy_alert
    "Are you sure?"+"\n"+"\n"+"Removing item will remove all associated order data"
  end

  def directory_partials(dir)
    dir = Dir.entries("app/views/" + dir)[2..-1]
    arr = []
    dir.map {|x| arr << x.slice(1..(x.index('.')-1)) }
    return arr
  end
end

