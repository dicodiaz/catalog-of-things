class Genre
  attr_accessor :name
  attr_reader :items, :id

  def initialize(id: rand(1000), name: nil)
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
  end

  def self.from_parsed_json(genre, _helper_data)
    new(id: genre['id'], name: genre['name'])
  end
end
