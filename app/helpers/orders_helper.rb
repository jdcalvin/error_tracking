module OrdersHelper

	def total_by_date(date, arg)
		date = date.in_time_zone
		arg.select {|x| x.created_at >= date.beginning_of_day && x.created_at <=  date.end_of_day }.count
	end

	def quality_by_date(date)
		num = total_by_date(date, @correct)/total_by_date(date, @orders).to_f*100
		num.round(2)
	end

	def quality
		(@correct.size/@orders.size.to_f*100).round(2)
	end

  def calendar_month(arg)
    first = @date.beginning_of_month.day
    last = @date.end_of_month.day
    total = []
    last.times do |x|
      x = x + 1
      total << by_date(Date.parse("#{x}.#{@date.month}.#{@date.year}"), arg)
    end
    return total
  end

  def get_months
  	arr = []
		12.times do |month|
			month = month + 1
			arr << Date::MONTHNAMES[month]
		end
		return arr
	end

end
