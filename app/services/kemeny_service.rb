class KemenyService

  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def compareTwo(x, y)
    xGtY = 0
    xEqY = 0
    xLtY = 0

    @input.each do |_, profile|
      xFound = false
      yFound = false
      profile.each do |b|
        if b.include?(x) && b.include?(y)
          xEqY += 1
        elsif b.include?(x)
          if !yFound
            xGtY += 1
          end
          xFound = true
        elsif b.include?(y)
          if !xFound
            xLtY += 1
          end
          yFound = true
        end
      end
    end
    print "Results: #{x} #{y} #{[xGtY, xEqY, xLtY]} \n"
    [xGtY, xEqY, xLtY]
  end

  def pairCombination(movies)
    movies.combination(2).to_a
  end

end