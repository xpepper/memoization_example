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

class MemoDiscounter < Discounter
  def initialize
    @memory = {}
  end

  def discount(*skus)
    if @memory.has_key?(skus)
      @memory[skus]
    else
      @memory[skus] = super
    end
  end
end


d = MemoDiscounter.new
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
puts d.discount(2,3,4)
