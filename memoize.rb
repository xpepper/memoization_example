class Discounter
  def discount(*skus)
    expensive_discount_calculator(*skus)
  end

  private

  def expensive_discount_calculator(*skus)
    puts "expensive calculation for #{skus.inspect}"
    skus.inject(0) {|sum, e| sum + e }
  end
end

d = Discounter.new
def memoize(object, method)
  singleton_class = class << object; self; end

  singleton_class.class_eval do
    memory ||= {}

    define_method(method) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        memory[args] = super(*args )
      end
    end
  end
end
memoize(d, :discount)


puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
