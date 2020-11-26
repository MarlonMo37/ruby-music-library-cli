require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist != nil
            self.artist = artist
        end

        if genre != nil
            self.genre = genre
        end   
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
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
        # binding.pry
        all.detect {|s| s.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        stuff = filename.split(" - ")
        artist_name = stuff[0]
        song_name = stuff[1]
        genre_name  = stuff[2].gsub(".mp3", "")
        
        artist = Artist.find_or_create_by_name(artist_name)
        genre  = Genre.find_or_create_by_name(genre_name)

        self.new(song_name, artist, genre)

    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap{ |s| s.save}
        
    end
end