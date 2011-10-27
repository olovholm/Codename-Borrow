#!/usr/bin/env ruby
$KCODE = 'u'
require 'iconv'
unless ARGV[0].nil?
  puts "This program will now try to convert your file #{ARGV[0]} to a more Norwegian-friendly UTF-8 format"
  file = File.new(ARGV[0])
  while (line = file.gets)
  #begin
    puts "The line was changed from: \n#{line} to \n"
    newline=Iconv.iconv('UTF-8', 'ASCII',line)
  #rescue Iconv::IllegalSequence
    puts "ÆØÅ feil"
    newline.each_byte do |c|  
      puts c 
    end
    #å newline = newline.gsub("","Å")
    
  #end
    #newline = Unicode.normalize_KD(line).gsub(/[^\x00-\x7F]/n,'')
    puts "#{newline}"
  end
else 
  puts "Usage: data_recorder filename \n"
  puts "Mission: To change your file from Ascii to UTF-8"
end