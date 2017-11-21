class MajorityService

  # def self.vote(votes)
  #   votes.values.flatten.each_with_object(Hash.new(0)) { |vote, counts| counts[vote] += 1 }.reduce({}) { |h, (k, v)| (h[v] ||= []) << k; h }.max.last
  # end

  def self.vote(votes)
    votes = votes.values.flatten

    counts = Hash.new(0)
    votes.each do |vote|
      counts[vote] += 1
    end

    counts.max_by { |k, v| v }
  end
end