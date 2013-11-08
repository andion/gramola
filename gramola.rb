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
#   Non-shuffle option: -l
# 
#

module Gramola
  require 'optparse'

  MUSIC_FOLDER='Music'
  MUSIC_EXTENSIONS='*{.mp3}'

  class Player

    def initialize(argv)
      parse_options(argv)
      @files  = Dir[File.join(Dir.home,MUSIC_FOLDER,'**',MUSIC_EXTENSIONS)]      
      @songs  = filter_by_groups(@files,@groups)
      @length = get_total_length(@songs)
    end

    def parse_options(argv)
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: gramola.rb [-l] [file ...]. Shuffles all *.mp3 under ~/Music by default."
        opts.on('-l', '--list', "Play the files in order") {@shuffle = false}
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end        
        @groups = opts.parse!
      end      
    end

    def info
      "Playing #{@songs.size} songs for about #{print_length(@length)} in #{shuffle_info}"    
    end

    def play      
      (@shuffle ? @songs.shuffle : @songs).each{|s| `afplay "#{s}"`} #Main script function
    end

    private

    def shuffle_info
      @shuffle ? "shuffle mode" : "list mode"      
    end

    def filter_by_groups(files,groups)
      if groups.any?
        files.select{|f| f =~ Regexp.new("#{groups * '|'  }") }
      else
        files
      end
    end    

    # Gets lenght in seconds from +afinfo+ command output
    def get_song_length(afinfo)
      afinfo.lines[2].split[0].to_f
    end

    # Returns total lenght of the +files+ in seconds
    def get_total_length(files)
      files.inject(0){|acc,f| acc = acc + get_song_length(`afinfo -b "#{f}"`); acc}
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
gramola = Gramola::Player.new ARGV
puts gramola.info
gramola.play