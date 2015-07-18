module Searchable

  extend ::ActiveSupport::Concern

  def search_by(field, search)
    if search
      where("#{field.to_s} ilike :q", q: "%#{search}%").order("#{field.to_s} ASC")
    else
      scoped
    end  
  end
end