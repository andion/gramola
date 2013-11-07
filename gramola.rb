#!/usr/bin/env ruby
#
# GRAMOLA: shuffle play all the mp3 files under your '/Music' 
#   folder using afplay (OSX 10.5+ only)
#
# Many features xD: 
#   Run:'ruby gramola.rb' or do once 'chmod +x gramola.rb' and then exec with './gramola.rb'
#   "Background mode": './gramola.rb &'
#   Pause: Ctrl-Z or 'fg' + Crl-Z if background
#   Resume: 'fg'
#   Play specific groups/keywords: './gramola.rb 'Group name' Keyword 'Other group'
# 
#

module Gramola
  MUSIC_FOLDER='Music'
  MUSIC_EXTENSIONS='*{.mp3}'

  class Player

    def initialize(argv)
      files = Dir[File.join(Dir.home,MUSIC_FOLDER,'**',MUSIC_EXTENSIONS)]
      @songs = filter_by_groups(files,argv)
    end

    def print_info
      puts "Playing #{@songs.size} songs for about #{print_length(total_length(@files))}"
    end

    def play
      @songs.shuffle.each do |s|
        `afplay "#{s}"`
    end
      
    private  

    def filter_by_groups(files,groups)
      if groups.any?
        files.select{|f| f =~ Regexp.new("#{groups * '|'  }") }
      else
        files
      end
    end

    # Gets lenght in seconds from +afinfo+ command output
    def get_length(afinfo)
      afinfo.lines[2].split[0].to_f
    end

    # Returns total lenght of the +files+ in seconds
    def total_length(files)
      files.inject(0){|acc,f| acc = acc + get_length(`afinfo -b "#{f}"`); acc}
    end

    def print_length(seconds)
      m, s = seconds.divmod(60)
      h, m = m.divmod(60)
      d, h = h.divmod(24)
      [d > 0 ? ("%d day" % d) : nil, h > 0 ? ("%d hours" % h) : nil,
        m ? ("%d minutes" % m) : ("%d seconds... Orly?")].compact * ' ' 
    end
  end
end

# Main
Gramola::Player.new ARGV
Gramola::Player.print_info
Gramola::Player.play