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
end

