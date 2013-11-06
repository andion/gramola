#!/usr/bin/env ruby
# Just shuffle play all the music files under your '/Music' folder using afplay
# Many features xD: 
#   Run:'ruby gramola.rb' or do once 'chmod +x gramola.rb' and then exec with './gramola.rb'
#   "Background mode": './gramola.rb &'
#   Pause: Ctrl-Z or 'fg' + Crl-Z if background
#   Resume: 'fg'
# 
#
MUSIC_FOLDER='Music'
MUSIC_EXTENSIONS='*{.mp3}' #TODO: check all afplay supported

Dir[File.join(Dir.home,MUSIC_FOLDER,'**','*Placebo*',MUSIC_EXTENSIONS)].shuffle.each do |m|
	%x{"afplay '#{m}'"}
end