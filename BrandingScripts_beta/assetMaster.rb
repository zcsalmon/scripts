require 'open-uri'
require 'pathname'

$globalSelectHash = {}
$globalActiveHash = {}

$colorHash = {}

$myPath = "/Users/zcsalmon/mpp/"
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

def theAmazingColoration(brand)
  selected_asset = Pathname.new("#{$myPath}media/#{brand}/android2/res/drawable/tab_selected.png")
  active_asset = Pathname.new("#{$myPath}media/#{brand}/android2/res/drawable/tab_active.png")
  if selected_asset.exist? then
    selected = `convert #{selected_asset} -colors 1 -unique-colors txt:-`.split(" ").each { |item| if item.start_with?('#') && item.length > 1 then $globalSelectHash[brand] = item end}
  end
  if active_asset.exist? then
    active = `convert #{active_asset} -colors 1 -unique-colors txt:-`.split(" ").each { |item| if item.start_with?('#') && item.length > 1 then $globalActiveHash[brand] = item end}
  end
end

def thisCreatesAndroid2(brandList)
  for brand in brandList
    brandPath = Pathname.new("#{$myPath}#{brand}/android2/")
    if brandPath.exist?
      then
      `sh #{$myPath}media/#{brand}/android2.sh #{brand}`
    end
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


def grabColors(brand)
  File.open("#{$myPath}media/#{brand}/client.config", 'r') do |output|
    for line in output.readlines
      regex = /color_window_background_header=(.+)/
      line.match(regex)
      if $1 != nil
        
        color = $1
        break
      end
    end
  end
  return color
end

def fileInput(brand, color)
  Dir.chdir($myPath)
  Dir.pwd
  File.open("#{brand}/android2/client.config",'a') do |input|
    input.puts("color_tab_focus=" + color) #$globalActiveHash[brand].sub(/#/, ""))
    input.puts("color_selection_background=" + adjustToWhite(color).to_s) #$globalSelectedHash[brand].sub(/#/, ""))
    input.puts("folders_viewer=side_menu")
    input.puts("folders_viewer_side_menu_depth=1")
    input.puts("color_tab_not_focus=252525")
    #`sh assetMaster.sh create #{color} #{brand}`
  end
end

fileInput("testes", "663366")