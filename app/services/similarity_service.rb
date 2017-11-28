class SimilarityService

  def compare_social_ordering(file_path1, file_path2)
    file1 = File.readlines(file_path1)
    file2 = File.readlines(file_path2)

    rows = file1.length > file2.length ? file2.length : file1.length

    equal_output = 0
    rows.times do |i|
      equal_output += 1 if file1[i] == file2[i]
    end

    equal_output.to_f / rows
  end

  def compare_winner(file_path1, file_path2)
    file1 = File.readlines(file_path1)
    file2 = File.readlines(file_path2)

    rows = file1.length > file2.length ? file2.length : file1.length

    equal_output = 0
    rows.times do |i|
      equal_output += 1 if file1[i].split(',').first == file2[i].split(',').first
    end

    equal_output.to_f / rows
  end
end