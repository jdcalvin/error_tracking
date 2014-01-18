class Task < ActiveRecord::Base
	before_save {self.description = description.capitalize}
  belongs_to :category
  validates :description, :category_id, presence: true

  def self.convert_to_id

  end

  def self.cat_name
  end

  
end
