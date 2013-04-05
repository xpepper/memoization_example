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
d.discount(1,2,3)
d.discount(1,2,3)
d.discount(1,2,3)
d.discount(2,3,4)
d.discount(2,3,4)
d.discount(2,3,4)
d.discount(2,3,4)
