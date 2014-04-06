FactoryGirl.define do
	factory :user do
		first_name "Test"
		last_name "User"
		sequence(:email) {|n| "user-#{n}@test.com"}
		association :organization
		password "password"
		admin false
		active true
		factory :admin do
			admin true
		end
		factory :inactive do
			active false
		end
	end
end

