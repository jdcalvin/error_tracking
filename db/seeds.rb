# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cat = ["city lien", "datedown", "documents", "general", "names", "policy", "taxes"]
cat.each do |x|
Category.new(name: x).save
end

city_lien = ["did not update", "incorrect amount"]
datedown = ["did not run", "doc is incorrect", "wrong effective date",
						"missed exceptions", "did not update new vesting"]
documents = ["did not upload new docs", "labeled incorrectly", 
							"wrong docs uploaded"]
general = ["exceptions wrong", "wrong supp version"]

names = ["did not update name", "listing old buyers", "name incorrect", 
					"new buyers not added"]
policy = ["did not update amount", "incorrect FNF sheet", "missed new loan",
					"missed proposed insured", "wrong types/short term"]
taxes = ["did not update", "shown incorrectly", "wrong data"]

def convert_to_id(cat_name)
	cat_name = Category.find_by(name: cat_name).id
end


city_lien.each do |x|
	Task.new(description: x, category_id: convert_to_id("City Lien")).save
end

datedown.each do |x|
	Task.new(description: x, category_id: convert_to_id("Datedown")).save
end

general.each do |x|
	Task.new(description: x, category_id: convert_to_id("General")).save
end

names.each do |x|
	Task.new(description: x, category_id: convert_to_id("Names")).save
end

policy.each do |x|
	Task.new(description: x, category_id: convert_to_id("Policy")).save
end

taxes.each do |x|
	Task.new(description: x, category_id: convert_to_id("Taxes")).save
end