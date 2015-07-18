module Tracking
  class ErrorBreakdown

    def self.by_orders(orders)
      new_hash = Hash.new(0)
      hash = Hash.new{|k, v| k[v] = []}     

      orders.with_errors.each do |order|
        order.show_errors.each_pair do |k,v|
          hash[k] << v
        end
      end
  
      hash.each do |x|
        new_hash[x[0]] = x[1].flatten
      end
      new_hash.each_pair do |key, value|
        res = Hash[value.group_by {|x| x}.map {|k, v| [k,v.count]}]
        new_hash[key] = res
      end

      return new_hash
    end

    def self.by_order(order)
      show_errors = order.validations.select {|x| x.approval}
      hash = Hash.new{|k,v| k[v] = []}
  
      show_errors.each do |x| 
        hash[x.category_name] << x.task_description
        hash[x.category_name].sort
      end
      return hash
    end


  end
end