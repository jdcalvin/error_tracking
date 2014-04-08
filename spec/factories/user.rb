require 'faker'

FactoryGirl.define do
	factory :user do
		first_name {Faker::Name.first_name}
		last_name {Faker::Name.last_name}
		email {Faker::Internet.email}
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

