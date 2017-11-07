require 'rgl/adjacency'

class RankedPairsService

  class Pair
    attr_accessor :winner, :winner_votes, :loser, :loser_votes

    def initialize(first, first_votes, second, second_votes)
      @winner       = first_votes >= second_votes ? first : second
      @winner_votes = first_votes >= second_votes ? first_votes : second_votes
      @loser        = first_votes >= second_votes ? second : first
      @loser_votes  = first_votes >= second_votes ? second_votes : first_votes
    end

    def to_s
      "#{@winner}(#{@winner_votes}) : #{@loser}(#{@loser_votes})"
    end

    def to_a
      [@winner, @loser]
    end
  end

  def resolve(preferences)
    pairwise_results = tally(preferences)
    sorted_pairs     = rank_sort(pairwise_results)
    graph            = lock(sorted_pairs)
  end

  def tally(preferences)
    pair_hash = {}
    preferences.values.first.each { |x| pair_hash[x] = Hash.new(0) }

    preferences.each_value do |preference|
      preference.combination(2).to_a.each do |pair|
        pair_hash[pair.first][pair.last] += 1
      end
    end

    preferences.values.first.combination(2).to_a.map do |pair|
      Pair.new(pair.first, pair_hash[pair.first][pair.last], pair.last, pair_hash[pair.last][pair.first])
    end
  end

  def rank_sort(pairs)
    # This does not take into account how to sort when there are ties!
    pairs.sort_by(&:winner_votes).reverse
  end

  def lock(pairs)
    dg = RGL::DirectedAdjacencyGraph[]

    pairs.each do |pair|
      dg.add_edge(pair.winner, pair.loser)
      dg.remove_edge(pair.winner, pair.loser) if dg.cycles.any?
    end

    dg
  end
end