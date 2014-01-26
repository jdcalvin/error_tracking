#RailsCast #213
module CalendarHelper
  
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def count_errors(num)
    sum = 0
    orders_by_day(num).each do |x|
      if x.validations.where(approval:true).count > 0
        sum = sum + 1
      else
        sum
      end
    end
    return sum
  end

  def orders_by_day(num)
      return Order.where('created_at >= ? and created_at < ?', num, num+1)
  end

  def quality(num)
    errors = count_errors(num)
    total = orders_by_day(num).count
    return 100-(errors/total.to_f*100).round(2)
  end

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "qc1" if quality(day) >= 90
      classes << "qc2" if quality(day) >= 80 && quality(day) < 90
      classes << "qc3" if quality(day) >= 70 && quality(day) < 80 
      classes << "qc4" if quality(day) >= 60 && quality(day) < 70
      classes << "qc5" if quality(day) < 60
      classes << "notmonth" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end
  end

end
