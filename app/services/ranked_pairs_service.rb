require 'rgl/adjacency'
require 'set'

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
      "#{@winner} - #{@loser}"
    end

    def to_a
      [@winner, @loser]
    end
  end

  def resolve(preferences)
    @pairwise_results = tally(preferences)
    sorted_pairs      = rank_sort(@pairwise_results[:values])
    graph             = lock(sorted_pairs)
    social_choice_order(graph)
  end

  def resolve_timed(preferences)
    start             = Time.now
    @pairwise_results = tally(preferences)
    puts " - Tally time: #{(Time.now - start) * 1000}ms"

    start        = Time.now
    sorted_pairs = rank_sort(@pairwise_results[:values])
    puts " - Sort time: #{(Time.now - start) * 1000}ms"

    start = Time.now
    graph = lock(sorted_pairs)
    puts " - Lock time: #{(Time.now - start) * 1000}ms"

    start = Time.now
    order = social_choice_order(graph)
    puts " - Order time: #{(Time.now - start) * 1000}ms"

    order
  end

  def tally(preferences)
    pair_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }

    preferences.each_value do |preference|
      preference.combination(2).to_a.each do |pair|
        pair_hash[pair.first][pair.last] += 1
      end
    end

    pairs = Hash.new { |hash, key| hash[key] = {} }
    pairs[:values] = []
    preferences.values.first.combination(2).to_a.each do |pair|
      p = Pair.new(pair.first, pair_hash[pair.first][pair.last], pair.last, pair_hash[pair.last][pair.first])
      pairs[p.winner][p.loser] = p
      pairs[:values] << p
    end

    pairs
  end

  def rank_sort(pairs)
    return pairs if pairs.length <= 1

    halves = pairs.each_slice((pairs.size/2.0).round).to_a
    x      = rank_sort(halves.first)
    y      = rank_sort(halves.last)

    sorted_array = []
    until x.empty? && y.empty?
      if x.empty?
        sorted_array.concat(y)
        y = []
      elsif y.empty?
        sorted_array.concat(x)
        x = []
      elsif x.first.winner_votes > y.first.winner_votes
        sorted_array << x.shift
      elsif y.first.winner_votes > x.first.winner_votes
        sorted_array << y.shift
      else
        loser_pair = @pairwise_results[x.first.loser][y.first.loser] || @pairwise_results[y.first.loser][x.first.loser]
        sorted_array << (loser_pair.nil? || loser_pair.loser == x.first.loser ? x.shift : y.shift)
      end
    end

    sorted_array
  end

  def lock(pairs)
    graph = RGL::DirectedAdjacencyGraph[]

    pairs.each do |pair|
      graph.add_edge(pair.winner, pair.loser)
      graph.remove_edge(pair.winner, pair.loser) if cycles?(graph, pair.loser)
    end

    graph
  end

  def cycles?(graph, start_vertex, visited_nodes = {})
    return true if visited_nodes[start_vertex]

    graph.each_adjacent(start_vertex).each do |current_vertex|
      visited_nodes[start_vertex] = true
      cycle_found = dfs(graph, current_vertex, visited_nodes)
      return cycle_found if cycle_found
    end

    false
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