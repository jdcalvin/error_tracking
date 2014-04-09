require 'faker'

FactoryGirl.define do
	factory :organization do
		title {Faker::Company.name}
		after(:create) do |organization|
			create(:admin, :organization => organization)
			create(:order_type, :organization => organization)
		end
	end
end
