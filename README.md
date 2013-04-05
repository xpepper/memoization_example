Memoization example
===================

Taken from the Dave Thomas' video on Ruby Object Model, lession #5.

We start from a simple Discounter class which has a #discount method which is fairly expensive to run. 
So we introduce a sort of "method caching", in other words: memoization.

```ruby
  ...
  def initialize
    @memory = {}
  end
  def discount(*skus)
    if @memory.has_key?(skus)
      @memory[skus]
    else
      @memory[skus] = expensive_discount_calculator(*skus)
    end
  end
  ...
```
