class DataManager
  def initialize(app)
    @app = app
  end

  def load_file(file_name)
    file_path = File.join('data', file_name)
    return [] unless File.exist?(file_path) && File.size(file_path).positive?

    data = JSON.load_file(file_path)
    p @app.authors
    helper_data = { labels: @app.labels, genres: @app.genres, authors: @app.authors }
    data.map { |elem| Object.const_get(elem['type']).from_parsed_json(elem, helper_data) }
  end

  def save_files
    File.write('data/books.json', @app.books.to_json)
    File.write('data/music_albums.json', @app.music_albums.to_json)
    File.write('data/games.json', @app.games.to_json)
  end
end
