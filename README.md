# Gramola

Gramola is a command-line script to call afplay on your Music collection
under ~/Music from your mac's Terminal.

I love my ipod shuffle. No screen, no hassle, just play some music. 

Gramola is just like that. Just run gramola and all your mp3's under your 
~/Music folder will be played in shuffle mode. You can also add search keywords 
or play them on list mode.

Simple and **battery friendly**.

![Activity monitor](/afplay_itunes_vox_activity_monitor.png)

## Requirements

  OSX 10.5+

## Run
  
    $ gramola [-l] [keyword ...]

## Installation

    $ gem install gramola

## Usage
  
    $ gramola -h
    Usage: gramola.rb [-l] [keyword ...]. Shuffles all *.mp3 under ~/Music by default.
      -l, --list                       Play the files in order
      -h, --help                       Show this message    
  

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
