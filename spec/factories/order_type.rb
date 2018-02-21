FactoryBot.define do
	factory :order_type do
		sequence(:title) {|n| "Type #{n}" }
		association :organization

		after(:build) do |order_type|
			2.times do
				order_type.categories <<  build(:category, :order_type => order_type)
			end
		end
	end

	factory :invalid_order_type, class: OrderType do
		title nil
		association :organization
	end

end


