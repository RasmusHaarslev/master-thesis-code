class KemenyService

  def winner(preferences)
    @preferences = preferences

    score_hash = calculate_permutation_scores
    score_hash.key(score_hash.values.max)
  end

  private

  def calculate_permutation_scores
    scores = {}

    permutations.each do |permutation|
      score = 0

      permutation.combination(2).to_a.each do |x, y|
        score += new_score(x, y)
      end

      scores[permutation] = score
    end

    scores
  end

  def new_score(x, y)
    x_score = 0

    @preferences.each_value do |profile|
      if profile.index(x) > profile.index(y)
        x_score += 1
      end
    end
    x_score
  end

  def permutations
    @preferences.values.flatten.uniq.permutation.to_a
  end
end