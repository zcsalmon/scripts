require 'pathname'

$myPath = "/Users/zcsalmon/mpp/"
brands = ["entrep", "NYDN", "testes", "redOrbit", "ACR", "acs", "GolfWeek"]

$globalSelectHash = {}
$globalActiveHash = {}

def theAmazingColoration(brand)
  puts brand
  selected_asset = Pathname.new("#{$myPath}media/#{brand}/android/res/drawable/tab_selected.png")
  active_asset = Pathname.new("#{$myPath}media/#{brand}/android/res/drawable/tab_active.png")
  if selected_asset.exist? then
    selected = `convert #{selected_asset} -colors 1 -unique-colors txt:-`.split(" ")
    selected.each do |item|
      #puts item
      if item.start_with?('#') && item.length > 1 
        then $globalSelectHash[brand] = item
      end
    end
    puts "selected = " + $globalSelectHash[brand]
  end
  if active_asset.exist? then
    active = `convert #{active_asset} -colors 1 -unique-colors txt:-`.split(" ")
    active.each do |item|
      #puts item
      if item.start_with?('#') && item.length > 1 
        then $globalActiveHash[brand] = item
      end
    end
    puts "active = " + $globalActiveHash[brand]
  else
    
  end
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

for brand in brands
  
  
  theAmazingColoration(brand)
  puts "After adjust:"
  puts adjustToWhite($globalActiveHash[brand])
  
end