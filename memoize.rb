# using a DSL
module Memoize
  def remember(method, &block)
    define_method method, &block

    # get the original method from the target class
    original_method = instance_method(method)

    memory ||= {}
    define_method(method) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        # attach the original method to the instance
        bound_method = original_method.bind(self)
        # execute the original method
        memory[args] = bound_method.call(*args)
      end
    end

  end
end

class Discounter
  extend Memoize

  remember :discount do |*skus|
    expensive_discount_calculator(*skus)
  end

  private

  def expensive_discount_calculator(*skus)
    puts "expensive calculation for #{skus.inspect}"
    skus.inject(0) {|sum, e| sum + e }
  end
end

d = Discounter.new

puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
