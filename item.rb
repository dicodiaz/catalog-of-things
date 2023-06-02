require 'date'

class Item
  attr_accessor :publish_date, :archived, :title
  attr_reader :genre, :author, :label, :id

  def initialize(id: nil, title: nil, publish_date: nil, archived: nil)
    @id = id || rand(1000)
    @title = title
    @publish_date = publish_date
    @archived = archived
  end

  def genre=(genre)
    @genre&.items&.delete(self)
    @genre = genre
    genre.items << self
  end

  def author=(author)
    @author&.items&.delete(self)
    @author = author
    @author.items << self
  end

  def label=(label)
    @label&.items&.delete(self)
    @label = label
    @label.items << self
  end

  def move_to_archive
    @archived = true if can_be_archived?
    self
  end

  private

  def can_be_archived?
    Date.today.year - @publish_date.year > 10
  end
end
