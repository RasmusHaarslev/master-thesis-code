class Lexer

  def initialize(filename)
    @filename = filename
  end

  def movies
    file = File.open(@filename, 'r')

    movies = file[0].split(',')
    file.close

    movies
  end

  def voters
    file = File.open(@filename, 'r')

    voters = file[1].split(',')
    file.close

    voters
  end

  def preferences
    file = File.open(@filename, 'r')

    tokens = []
    file[3..-1].each do |line|
      tokens << tokenize(line)
    end
    file.close

    tokens
  end

  private

  def tokenize(sequence)
    tokens = []

    match = /^(?<voter>\S+): (?<preferences>[\S ]+)$/.match(sequence)
    tokens << match[:voter]
    tokens << match[:preferences].split(/(>=)|(>)/)

    tokens
  end
end