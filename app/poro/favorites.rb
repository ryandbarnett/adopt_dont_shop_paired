class Favorites
  attr_reader :contents
  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def extract_ids
    @ids = @contents.map do |key, value|
      key.to_i
    end
  end

  def translate_ids
    @ids.map do |id|
      Pet.find(id)
    end
  end
end
