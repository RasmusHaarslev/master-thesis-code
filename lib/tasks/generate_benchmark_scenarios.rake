namespace :benchmark do
  desc 'Generates 198 files used for benchmarking.'
  task :generate_scenarios => :environment do
    gp_service = GeneratePreferencesService.new
    Dir.mkdir("#{Rails.root}/spec/benchmark_files") unless File.exists?("#{Rails.root}/spec/benchmark_files")

    [5, 25].each do |voters|
      Dir.mkdir("#{Rails.root}/spec/benchmark_files/#{voters}_voters") unless File.exists?("#{Rails.root}/spec/benchmark_files/#{voters}_voters")

      print "#{voters} voters                                       \n"

      (2..100).each do |alternatives|
        print "[#{alternatives} of 100] Generating scenario\r"

        File.open("#{Rails.root}/spec/benchmark_files/#{voters}_voters/#{alternatives}_alternatives.json", 'w') do |f|
          f.write JSON.generate gp_service.generate(voters, alternatives, alternatives, alternatives)
        end
      end
    end

    puts 'Done.                                                   '
  end
end