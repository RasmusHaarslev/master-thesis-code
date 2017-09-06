class KemenyService

    attr_accessor :input

    def initialize(input)
      @input = input
    end

    def compareTwo(x, y)
        xGtY = 0
        xEqY = 0
        xLtY = 0

        for a in input
            xFound = false
            yFound = false
            for b in a
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
        [xGtY, xEqY, xLtY]
    end

#print compareTwo('a', 'c', votes)
end