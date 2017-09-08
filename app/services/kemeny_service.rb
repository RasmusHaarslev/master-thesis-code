class KemenyService

  attr_accessor :input

  def initialize(input)
    @input = input
  end

  """
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
    [xGtY, xEqY, xLtY]
  end
  """

  def getScore(x,y )
    score = 0
    @input.each do |_,profile|
      yFound = false
      profile.each do |b|
        if b.include?(x)
          if !yFound
            score += 1
          end
        elsif b.include?(y)
          yFound = true
        end
      end
    end
    score
  end

  def pairwiseJunk(pairs)
    scores = Hash.new
    pairs.each do |ranking|
      score = 0
      ranking.combination(2).to_a.each do |x, y|
        score += getScore(x, y)
      end
      scores[ranking] = score
    end
    scores
  end

  def choicePairs(choices)
    choices.combination(2).to_a
  end

  def preferenceOrderings(choices)
    choices.permutation(choices.length).to_a
  end

  def getWinner(movies)
    prefs = preferenceOrderings(movies)
    rankingScores = pairwiseJunk(prefs)
    rankingScores.max_by{|k,v| v}
  end

end