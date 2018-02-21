FactoryBot.define do
	factory :task do
		sequence(:description) {|n| "Task #{n}" }
		association :category
	end
end
