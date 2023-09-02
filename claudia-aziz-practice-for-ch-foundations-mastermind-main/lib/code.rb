class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.each do |char|
      return false if !POSSIBLE_PEGS.include?(char.upcase)
    end
    true
  end

  def self.random(length)
    random = POSSIBLE_PEGS.keys
    pegs = []
    while pegs.length < length
      pegs << random.sample
    end
    Code.new(pegs)
  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  attr_reader :pegs

  def initialize(chars)
    raise "not valid pegs" if !Code.valid_pegs?(chars)
    @pegs = chars.map(&:upcase)
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    exact = 0
    guess.pegs.each_with_index do |peg, i|
      exact += 1 if @pegs[i] == peg
    end
    exact
  end

  def num_near_matches(guess)
    code_dup = self.pegs.dup
    guess_dup = guess.pegs.dup

    guess_dup.each_with_index do |peg, i|
      if peg == code_dup[i]
        code_dup[i] = nil
        guess_dup[i] = nil
      end
    end

    code_dup.delete(nil)
    guess_dup.delete(nil)

    near = 0

    guess_dup.each_with_index do |peg, i|
      if code_dup.include?(peg)
        near += 1
        code_dup.delete_at(code_dup.index(peg))
      end        
    end

    near 
  end

  def ==(guess)
    self.pegs == guess.pegs
  end

end