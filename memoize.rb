# Rewrite using modules
module Memoize
  def remember(method)
    original_method = "_original_#{method}".to_sym
    alias_method original_method, method.to_sym

    memory ||= {}
    define_method(method) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        memory[args] = send(original_method, *args)
      end
    end
  end
end

class Discounter
  extend Memoize

  def discount(*skus)
    expensive_discount_calculator(*skus)
  end

  remember :discount

  private

  def expensive_discount_calculator(*skus)
    puts "expensive calculation for #{skus.inspect}"
    skus.inject(0) {|sum, e| sum + e }
  end
end

# class Discounter
#   alias_method :_old_discount_, :discount

#   def discount(*args)
#     @memory ||= {}

#     if @memory.has_key?(args)
#       @memory[args]
#     else
#       @memory[args] = _old_discount_(*args)
#     end

#   end
# end

d = Discounter.new

puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
