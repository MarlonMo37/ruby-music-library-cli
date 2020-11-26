class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
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
        artist = self.new(name)
        artist
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        
        if songs.include?(song) != true
            songs << song
        end
    end

    def genres
        songs.collect{|s| s.genre }.uniq
    end
end