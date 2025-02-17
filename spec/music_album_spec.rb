require_relative '../music_album'

describe MusicAlbum do
  describe '#initialize' do
    before(:each) do
      @album = MusicAlbum.new(on_spotify: true, publish_date: Date.new(2012, 5, 31), archived: false, title: 'Title')
    end

    it 'creates a new instance of MusicAlbum' do
      expect(@album).to be_an_instance_of(MusicAlbum)
    end

    it 'should have attributes' do
      expect(@album).to have_attributes(on_spotify: true, publish_date: Date.new(2012, 5, 31), archived: false,
                                        title: 'Title')
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the album is on spotify and can be archived' do
      album = MusicAlbum.new(on_spotify: true, publish_date: Date.new(2012, 5, 31), archived: false, title: 'Title')
      can_be_archived = album.can_be_archived?
      expect(can_be_archived).to eq(true)
    end

    it 'returns false if the album is not on spotify' do
      album = MusicAlbum.new(on_spotify: false, publish_date: Date.new(2012, 5, 31), archived: false, title: 'Title')
      can_be_archived = album.can_be_archived?
      expect(can_be_archived).to eq(false)
    end

    it 'returns false if the album cannot be archived' do
      album = MusicAlbum.new(on_spotify: true, publish_date: Date.new(2014, 5, 31), archived: false, title: 'Title')
      can_be_archived = album.can_be_archived?
      expect(can_be_archived).to eq(false)
    end
  end
end
