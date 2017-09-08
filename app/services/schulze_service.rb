require 'matrix'
class SchulzeService

  def pair_wise_matrix(voting_proiles, candidate_index)
    number_candidates = voting_proiles[:person1].length
    pair_wise_preference_matrix = Matrix.zero(number_candidates)
    pair_wise_preference_array = pair_wise_preference_matrix.to_a

    voting_proiles.each do |key, array|
      profile = voting_proiles[key]
      for i in 0..(number_candidates-1)
        candidate_sym = profile[i].to_sym
        cand_index = candidate_index[candidate_sym]
        for j in (i+1)..(number_candidates-1)
          candidate_sym = profile[j].to_sym
          cand_index2 = candidate_index[candidate_sym]
          pair_wise_preference_array[cand_index][cand_index2] += 1 unless cand_index2 == cand_index
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

  def social_preference strongst_path_matrix

  end

end