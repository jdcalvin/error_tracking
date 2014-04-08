require 'faker'

FactoryGirl.define do
	factory :organization do
		title {Faker::Company.name}
	end
end
