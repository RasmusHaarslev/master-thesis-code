require 'securerandom'

class GeneratePreferencesService

  def generate(voters, alternatives, cinemas, times)
    @p = {}
    @v = generate_items('voter_', voters)
    @a = generate_items('alternative_', alternatives)
    @c = generate_items('cinema_', cinemas)
    @t = generate_items('time_', times)

    @p['voters']             = @v
    @p['movies']             = @a
    @p['times']              = @t
    @p['cinemas']            = @c
    @p['associations']       = generate_associations
    @p['movie_preferences']  = generate_preferences(@a)
    @p['time_preferences']   = generate_preferences(@t)
    @p['time_votes']         = generate_time_votes
    @p['cinema_preferences'] = generate_preferences(@c)

    @p
  end

  private

  def generate_items(name, amount)
    Array.new(amount) { |i| String.new(name) << (i+1).to_s }
  end

  def generate_associations
    ass = {}
    @t.each do |time|
      junk = {}
      @a.sample(1 + rand(@a.length)).each do |movie|
        junk[movie] = @c.sample(1 + rand(@c.length))
      end
      ass[time] = junk
    end
    ass
  end

  def generate_preferences(items)
    pref = {}
    @v.each do |voter|
      pref[voter] = items.shuffle
    end
    pref
  end

  def generate_time_votes
    pref = {}
    @v.each do |voter|
      pref[voter] = @t.sample(1 + rand(@t.length)).sort
    end
    pref
  end

end