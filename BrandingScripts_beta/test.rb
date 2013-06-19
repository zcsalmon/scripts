require 'pathname'
require 'open-uri'
$myPath = "/Users/zcsalmon/mpp/"
$n = 0

def grabColors(brand)
  File.open("#{$myPath}media/#{brand}/android2/client.config", 'r') do |output|
    for line in output.readlines
      regex = /color_window_background_header=(.+)/
      line.match(regex)
      puts line + "BRAND"
      if $1 != nil
        #puts $1
        $color = $1
        break
      else
        File.open("#{$myPath}media/#{brand}/client.config", 'r') do |output|
          for line in output.readlines
            regex = /color_window_background_header=(.+)/
            line.match(regex)
            puts line + "ROOT"
            if $1 != nil
              #puts $1
              $color = $1
              break
            end
          end
        end
      end
    end
  end
  return $color
end

brandslist = ["testes", "Jacksonville"]

for brand in brandslist
  puts grabColors(brand)
end






=begin
brandList = ["actanasc", "acemmejo", "addictio"]

`cd #{$myPath}workspace/client/android/util/`

for brand in brandList
  brandPath = Pathname.new("#{$myPath}media/#{brand}/android2/")
  puts brandPath
  if !brandPath.exist?
    then
    puts brand
    `sh /Users/zcsalmon/mpp/workspace/client/android/util/android2.sh #{brand}`
  end
end
=end