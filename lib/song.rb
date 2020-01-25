class Song
  
  attr_accessor :name, :artist, :genre
  
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    puts "Artist name is #{artist}"
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end
  
  def save
    self.class.all << self
  end
  
  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = self.new(name)
    self.all << song
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
     found_song = @@all.detect {|song| song.name == name}
     found_song
  end
  
  def self.find_or_create_by_name(name)
 
     found_song = self.find_by_name(name)
 
    if found_song
      found_song
    else
      self.create(name)
    end
    
  end
 
  def self.new_from_filename(filename)
  
    song_array = filename.split(" - ")
    
    name = song_array[1] = song_array[1].chomp(".mp3")
    artist_name = song_array[0]
    genre = song_array[2]
    
    new_song = new(name, artist_name, genre)
    new_song  
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre)
    
  end

  def self.create_from_filename(filename)
  
    result = self.new_from_filename(filename)
    song = self.create(name)
    song.name = result.name

  end
  
end #end Song Class  
