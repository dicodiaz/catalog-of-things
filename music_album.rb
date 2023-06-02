require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(args)
    super(id: args[:id], title: args[:title], publish_date: args[:publish_date], archived: args[:archived])
    @on_spotify = args[:on_spotify]
  end

  def can_be_archived?
    super && @on_spotify
  end

  def to_json(*args)
    {
      type: self.class,
      id: @id,
      title: @title,
      publish_date: @publish_date,
      archived: @archived,
      on_spotify: @on_spotify,
      genre_id: @genre.id
    }.to_json(*args)
  end

  def self.from_parsed_json(music_album, helper_data)
    new_music_album = new(id: music_album['id'], title:  music_album['title'],
                          publish_date: music_album['publish_date'], archived: music_album['archived'],
                          on_spotify: music_album['on_spotify'])
    new_music_album.genre = helper_data[:genres].find { |genre| genre.id == music_album['genre_id'] }
    new_music_album
  end
end
