require 'csv'
class OutputReaderService

  def compare_outputs(file_path_1, file_path_2)
    file_1 = CSV.read(file_path_1, {:col_sep => "&" })
    file_2 = CSV.read(file_path_2, {:col_sep => "&" } )

    file_1_headers = file_1.shift
    file_2_headers = file_2.shift

    index_output_file_1 = file_1_headers.index("Output")
    index_output_file_2 = file_2_headers.index("Output")

    equal_output = 0
    rows = 0
    if file_1.length > file_2.length
      rows = file_2.length
    else
      rows = file_1.length
    end


    for i in 0..rows-1
      equal_output = equal_output + 1 if file_1[i][index_output_file_1] == file_2[i][index_output_file_2]
    end

    equal_output.to_f/rows
  end

end