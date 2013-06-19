require 'open-uri'

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

puts getBrandList(adminUrl)
