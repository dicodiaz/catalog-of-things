require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(args)
    super(id: args[:id], title: args[:title], publish_date: args[:publish_date], archived: args[:archived])
    @multiplayer = args[:multiplayer]
    @last_played_at = args[:last_played_at]
  end

  def can_be_archived?
    super && (Date.today.year - @last_played_at.year > 2)
  end

  def to_json(*args)
    {
      type: self.class,
      id: @id,
      title: @title,
      publish_date: @publish_date,
      archived: @archived,
      multiplayer: @multiplayer,
      last_played_at: @last_played_at,
      label_id: @label.id
    }.to_json(*args)
  end

  def self.from_parsed_json(game, helper_data)
    new_game = new(id: game['id'], title: game['title'], publish_date: game['publish_date'],
                   archived: game['archived'], multiplayer: game['multiplayer'], last_played_at: game['last_played_at'])
    new_game.label = helper_data[:labels].find { |label| label.id == game['label_id'] }
    new_game
  end
end
