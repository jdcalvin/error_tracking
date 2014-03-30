class UserPolicy
	attr_reader :user, :record

	def initialize(user, record)
    @user = user
    @record = record
  end

	def create?
		@user.admin? or @user.nil?
	end

	def new?
		create?
	end

	def destroy?
		@user.admin?
	end

	def edit?
		@user.admin? or @user == current_user
	end

	def update?
		edit?
	end

end