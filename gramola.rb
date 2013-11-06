#!/usr/bin/env ruby
# Just play all the music files under your '/Music' folder using afplay
# Usage: './gramola.rb' or 'ruby gramola.rb'
#
MUSIC_FOLDER='Music'
MUSIC_EXTENSIONS='*{.mp3}' #TODO: check all afplay supported

music_files = Dir[File.join(Dir.home,MUSIC_FOLDER,'**',MUSIC_EXTENSIONS)]
music_files.each do |m|
	exec "afplay '#{m}'"
end