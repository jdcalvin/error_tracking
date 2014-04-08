FactoryGirl.define do
	factory :order do
		sequence(:order_name) {|n| "TST00#{n}" }
		association :order_type
		association :user
		note 'test note'
		
		trait :with_error do
			error true
			after(:build) do |order|
				order.order_type.tasks.each do |task|
					order.validations << build(:validation, 
						:order => order, :task => task, approval: true)
				end
			end
		end
		trait :no_error do
			error false
			after(:build) do |order|
				order.order_type.tasks.each do |task|
					order.validations << build(:validation, 
						:order => order, :task => task, approval: false)
				end
			end
		end
	end
end

