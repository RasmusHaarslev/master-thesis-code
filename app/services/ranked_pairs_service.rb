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
  end

  def resolve(preferences)
    pairwise_results = tally(preferences)
    sorted_pairs     = rank_sort(pairwise_results)
    graph            = lock(sorted_pairs)
    social_choice_order(graph)
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
    graph = RGL::DirectedAdjacencyGraph[]

    pairs.each do |pair|
      graph.add_edge(pair.winner, pair.loser)
      graph.remove_edge(pair.winner, pair.loser) if graph.cycles.any?
    end

    graph
  end

  def social_choice_order(graph)
    order = []

    graph.vertices.each do |_|
      winner = source(graph)
      order << winner
      graph.remove_vertex(winner)
    end

    order
  end

  def source(graph)
    vertices = graph.vertices

    graph.edges.each do |edge|
      vertices.delete(edge.target)
    end

    vertices.first
  end

  def schwartz_set(graph)
    is_in_maximal = graph.vertices

    has_path = {}
    graph.vertices.each { |vertex| has_path[vertex] = Hash.new(false) }
    graph.edges.each do |edge|
      has_path[edge.source][edge.target] = true
    end

    graph.vertices.each do |k|
      graph.vertices.each do |i|
        next if k == i

        graph.vertices.each do |j|
          next if k == j || i == j

          has_path[i][j] = true if has_path[i][k] && has_path[k][j]
        end
      end
    end

    graph.vertices.each do |i|
      graph.vertices.each do |j|
        next if i == j

        is_in_maximal.delete(i) if has_path[j][i] && !has_path[i][j]
      end
    end

    is_in_maximal
  end
end