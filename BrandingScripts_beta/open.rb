#!/usr/bin/env ruby
require 'open-uri'
require 'pathname'

$MyPath = `echo $HOME`.sub("\n", "")
$colorHash = {}
adminUrl = "http://live.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=brand"

def getBrandList(url)
  brandList = []
  open(url) do |f|
    for line in f.readlines
      regex = /\"\.([a-zA-Z]*)\"/
      line.match(regex)
      if $1 != nil
        brandList << $1
      end
    end
    return brandList
  end
end
def fileInput(brand, color)
  returnDir = Dir.pwd
  
  Dir.chdir("#{$MyPath}/mpp/media/#{brand}/android2/")
  puts Dir.pwd
  File.open('client.config','a') do |input|
    input.puts("color_tab_focus=" + color) #$globalActiveHash[brand].sub(/#/, ""))
    input.puts("color_selection_background=" + adjustToWhite(color).to_s()) #$globalSelectedHash[brand].sub(/#/, ""))
    input.puts("folders_viewer=side_menu")
    input.puts("folders_viewer_side_menu_depth=1")
    input.puts("color_tab_not_focus=252525")
    Dir.chdir(returnDir)
    `sh assetMaster.sh create #{color} #{brand}`
  end
end

def grabColors(brand)
  File.open("#{$MyPath}/mpp/media/#{brand}/android2/client.config", 'r') do |output|
    for line in output.readlines
      regex = /color_window_background_header=(.+)/
      line.match(regex)
      if $1
        $colorHash[brand] = $1
        break
      end
    end
    if $1 == nil
      File.open("#{$MyPath}/mpp/media/#{brand}/client.config", 'r') do |output|
        for line in output.readlines
          regex = /color_window_background_header=(.+)/
          line.match(regex)
          if $1
            $colorHash[brand] = $1
            break
          end
        end
      end
    end
  end
return $colorHash[brand]
end

def thisCreatesAndroid2(brandList)
  reDur = Dir.pwd
  Dir.chdir("#{$MyPath}/mpp/workspace/client/android/util/")
  for brand in brandList
    brandPath = Pathname.new("#{$MyPath}/media_temp/#{brand}/android2/")
    if !brandPath.exist?
      then
      `sh android2.sh #{brand}`
    end
  end
  Dir.chdir(reDur)
end
def adjustToWhite(color)
  if color != nil
    then
    oct = '0x'
    white = 255
    percent = 2.55
    nuColors = []
    colors = []
    regex = /([a-zA-Z0-9]{2})([a-zA-Z0-9]{2})([a-zA-Z0-9]{2})/
    if color.match(regex)
      then
      #puts "pre math: " + $1 + $2 + $3
      colors << (oct + $1).hex
      colors << (oct + $2).hex
      colors << (oct + $3).hex
    else
      return 0
    end

    for color in colors
      value = (((((100 - (color / percent)) / 100) * white) / 10) + color).ceil
      nuColors << value.to_s(16)
    end
    return nuColors[0] + nuColors[1] + nuColors[2]
  else
    puts color
    return 0
  end
end
blist = getBrandList(adminUrl)

thisCreatesAndroid2(blist)

for brand in blist
  grabColors(brand)
  fileInput(brand, $colorHash[brand])
end

#puts grabColors("testes")

#fileInput(ARGV[0], ARGV[1])
=begin


puts Dir.pwd
Dir.chdir($MyPath)
puts Dir.pwd
=end