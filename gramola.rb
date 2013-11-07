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
MUSIC_FOLDER='Music'
MUSIC_EXTENSIONS='*{.mp3}'

groups = ARGV
search_string = File.join(Dir.home,MUSIC_FOLDER,'**',MUSIC_EXTENSIONS)

files = Dir[search_string]

def filter_by_groups(files,groups)
	if groups.any?
		files.select{|f| f =~ Regexp.new("#{groups * '|'	}") }
	else
		files
	end
end

# Gets lenght in seconds from +afinfo+ command output
def get_length(afinfo)
	afinfo.lines[2].split[0].to_f
end

# Returns total lenght of the +files+ in minutes
def total_length(files)
	seconds = files.inject(0){|acc,f| acc = acc + get_length(`afinfo -b "#{f}"`); acc}
	print_length(seconds)
end

def print_length(seconds)
	(minutes = (seconds / 60.0).to_i) < 60 ? "#{minutes} minutes" : "#{minutes / 60} hours"
end

def print_info(files)
	puts "Playing #{files.size} files for about #{total_length(files)}"
end

# Main
songs = filter_by_groups(files,groups)
print_info(songs)

songs.shuffle.each do |s|
	`afplay "#{s}"`
end