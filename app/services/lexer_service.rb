class LexerService

  attr_accessor :input

  def initialize(input)
    @input = input.map { |line| line.rstrip }
  end

  def voters
    @input[0].split(',')
  end

  def movies
    @input[1].split(',')
  end

  def preferences
    tokens = []
    @input[3..-1].each do |line|
      line.chomp!
      tokens << tokenize(line)
    end

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