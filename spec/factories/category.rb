FactoryBot.define do
	factory :category do
		sequence(:name) {|n| "Category #{n}" }
		association :order_type

		after(:build) do |category|
			2.times do
				category.tasks << build(:task, :category => category)
			end
		end
	end
end
