class Author
  attr_accessor :first_name, :last_name
  attr_reader :items, :id

  def initialize(id: rand(1000), first_name: nil, last_name: nil)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.author = self
  end

  def self.from_parsed_json(author, _helper_data)
    new(id: author['id'], first_name: author['first_name'], last_name: author['last_name'])
  end
end
