class Schulze
  def pair_wise_matrix
    # Voters: person1, person2, person3, person4
    # Candidates/alternatives: A, B, C, D
    voting_proiles = {
        person1: ['A', 'B', 'D', 'C'],
        person2: ['B', 'D', 'C', 'A'],
        person3: ['D', 'C', 'D', 'A'],
        person4: ['A', 'C', 'D', 'B']
    }
    candidate_index = {
        A: 0,
        B: 1,
        C: 2,
        D: 3
    }
    number_candidates = test[:person1].length
    pair_wise_preference = Array.new(number_candidates){ Array.new(number_candidates) }

    voting_proiles.each do |key, array|
      profile = voting_proiles[key]
      for candidate in profile
        candidate_sym = candidate.to_sym
        cand_index = candidate_index[candidate_sym]
        for index in cand_indexnumber_candidates
          pair_wise_preference[cand_index][index] += 1
        end
      end
    end

  end
end