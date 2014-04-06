FactoryGirl.define do
	factory :task do
		sequence(:description) {|n| "Task #{n}" }
		category
	end
end
