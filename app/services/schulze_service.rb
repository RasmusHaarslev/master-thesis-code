require 'matrix'
class SchulzeService

  def calculate_schulze(preferences)
    preferences = preferences.each{ |key, array| preferences[key] = array.flatten}
    key, value = preferences.first
    candidate_index = Hash[preferences[key].sort.zip (0..preferences[key].size)]
    pair_wise_matrix = pair_wise_matrix(preferences, candidate_index)
    strongest_path_matrix = strongest_path_matrix(pair_wise_matrix)
    social_preference_ranking(strongest_path_matrix, candidate_index)
  end


  def pair_wise_matrix(voting_proiles, candidate_index)
    number_candidates = voting_proiles.first[1].length
    pair_wise_preference_matrix = Matrix.zero(number_candidates)
    pair_wise_preference_array = pair_wise_preference_matrix.to_a

    voting_proiles.each do |key, array|
      profile = voting_proiles[key]
      for i in 0..(number_candidates-1)
        candidate = profile[i]
        cand_index = candidate_index[candidate]
        for j in (i+1)..(number_candidates-1)
          candidate = profile[j]
          cand_index2 = candidate_index[candidate]
          pair_wise_preference_array[cand_index][cand_index2] += 1 unless (cand_index2 == cand_index)
        end
      end
    end

    Matrix[pair_wise_preference_array]
  end

  def strongest_path_matrix pair_wise_preference_matrix
    array_to_work_with = pair_wise_preference_matrix.to_a[0]
    size = pair_wise_preference_matrix.column_size
    strongst_path_matrix = Matrix.zero(size).to_a
    for i in 0..(size-1)
      for j in 0..(size-1)
        unless i == j
          if  array_to_work_with[i][j] > array_to_work_with[j][i]
            strongst_path_matrix[i][j] = array_to_work_with[i][j]
          end
        end
      end
    end

    for i in 0..(size-1)
      for j in 0..(size-1)
        unless i == j
          for k in 0..(size-1)
            if (i != k and j != k)
              min = [strongst_path_matrix[j][i], strongst_path_matrix[i][k]].min
              strongst_path_matrix[j][k] = [strongst_path_matrix[j][k], min].max
            end
          end
        end
      end
    end

    Matrix[strongst_path_matrix]

  end

  def social_preference_ranking(strongst_path_matrix, candidate_index)
    size = strongst_path_matrix.column_size
    array_to_work_with = strongst_path_matrix.to_a[0]
    candidate_score = candidate_index.clone
    candidate_score = candidate_score.each{ |k, v| candidate_score[k] = 0 }
    revertes_candidate_index = candidate_index.invert

    for i in 0..(size-1)
      candidate = revertes_candidate_index[i]
      for j in 0..(size-1)
        unless i == j
          if array_to_work_with[i][j] > array_to_work_with[j][i]
            candidate_score[candidate] += 1
          end
        end
      end
    end
    candidate_score.sort_by{|k,v| v}.map{|x| x[0]}.reverse
  end

end