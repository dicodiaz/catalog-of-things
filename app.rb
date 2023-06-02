require_relative 'genre'
require_relative 'music_album'
require_relative 'book'
require_relative 'label'
require_relative 'game'
require_relative 'author'
require_relative 'data_manager'
require 'json'

class App
  attr_reader :genres, :labels, :music_albums, :books, :authors, :games

  def initialize
    @data_manager = DataManager.new(self)
    @authors = @data_manager.load_file('authors.json')
    @genres = @data_manager.load_file('genres.json')
    @labels = @data_manager.load_file('labels.json')
    @books = @data_manager.load_file('books.json')
    @music_albums = @data_manager.load_file('music_albums.json')
    @games = @data_manager.load_file('games.json')
  end

  def list_books
    if @books.empty?
      puts '', 'There are no books', ''
    else
      puts '', @books, ''
    end
  end

  def list_music_albums
    if @music_albums.empty?
      puts("\n- There are no music albums -")
      return
    end

    puts 'Music albums:'
    @music_albums.each_with_index do |music_album, index|
      puts "#{index + 1}. Title: #{music_album.title} | Publish date: #{music_album.publish_date} |" \
           "Archived: #{music_album.archived} | On Spotify: #{music_album.on_spotify} | " \
           "Genre: #{music_album.genre.name}"
    end
  end

  def list_games
    if @games.empty?
      puts("\n- There are no games -")
      return
    end

    puts 'Games:'
    @games.each_with_index do |game, index|
      puts "#{index + 1}. Title: #{game.title} | Publish date: #{game.publish_date} | " \
           "Archived: #{game.archived} | Multiplayer: #{game.multiplayer} | " \
           "Last played: #{game.last_played_at} | Author: #{game.author.first_name} #{game.author.last_name}"
    end
  end

  def list_genres
    @genres.empty? && puts("\n- There are no genres -")

    puts 'Genres:'
    @genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_labels
    if @labels.empty?
      puts '', 'There are no labels', ''
    else
      puts('', @labels, '')
    end
  end

  def list_authors
    @authors.empty? && puts("\n- There are no authors -")
    puts 'Authors:'
    @authors.each_with_index do |author, index|
      puts "#{index + 1}. #{author.first_name} #{author.last_name}"
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    print 'Publish date (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Cover state [good/bad]: '
    cover_state = gets.chomp
    print 'Is it archived? [Y/N]: '
    archived = gets.chomp.match?(/^[yY]$/)
    puts 'Please select an author:'
    list_authors
    author_id = gets.chomp.to_i
    relevant_author = @authors.find { |author| author.id == author_id }

    new_book = Book.new(publish_date: publish_date, archived: archived, publisher: publisher, cover_state: cover_state,
                        title: title)
    new_book.author = relevant_author
    @books << new_book

    puts '', 'The book was created successfully', ''
  end

  def create_music_album
    print 'Title: '
    title = gets.chomp
    print 'Publish date (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Is it on Spotify? (y/n): '
    on_spotify = gets.chomp == 'y'
    print 'Is it archived? (y/n): '
    archived = gets.chomp == 'y'
    puts 'Please select a genre: '
    list_genres
    genre_id = gets.chomp.to_i
    relevant_genre = @genres.find { |genre| genre.id == genre_id }

    new_music_album = MusicAlbum.new(title: title, publish_date: publish_date, archived: archived,
                                     on_spotify: on_spotify)
    new_music_album.genre = relevant_genre
    @music_albums << new_music_album

    puts '', 'The music album was created successfully', ''
  end

  def create_game
    print 'Title: '
    title = gets.chomp
    print 'Publish date (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Is it archived? (y/n): '
    archived = gets.chomp == 'y'
    print 'Is it multiplayer? (y/n): '
    multiplayer = gets.chomp == 'y'
    print 'Last played at (YYYY/MM/DD): '
    last_played_at = Date.new(*gets.chomp.split('/').map(&:to_i))
    puts 'Please select a label: '
    list_labels
    label_id = gets.chomp.to_i
    relevant_label = @labels.find { |label| label.id == label_id }

    new_game = Game.new(title: title, publish_date: publish_date, archived: archived, multiplayer: multiplayer,
                        last_played_at: last_played_at)
    new_game.label = relevant_label
    @games << new_game

    puts '', 'The game was created successfully', ''
  end

  def exit
    @data_manager.save_files
  end
end
