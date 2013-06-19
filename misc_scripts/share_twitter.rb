#!/usr/bin/env ruby
require 'pathname'

adminUrl = "http://live.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=brand"
require 'open-uri'

$home = `echo $HOME`.sub("\n","")

def getBrandList(url)
  # => Instanciate an array for the brandList to live in
  brandList = []
  # => Opens the given url and reads every line, adding the portion that matches the regex to the brandList array
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


def configInput(brand)
    themePath = $home + "/mpp/media/#{brand}/_themes/global"
    android = themePath + "/android"
    blackberry = themePath + "/blackberry"
    ios = themePath + "/ios"
    
    
    if File.directory? themePath
        then
        puts brand
        if !File.directory? android
            then
            puts "ANDROID missing"
            Dir.mkdir(themePath + "/android")
        
        end
        if !File.exists?(android + "/client.config") then
            andFile = android + "/client.config"
            File.open(android + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        
        else
            File.open(android + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        end
        if !File.directory? blackberry
            then
            puts "BLACKBERRY missing"
            Dir.mkdir(themePath + "/blackberry")
        
        end
        if !File.exists?(blackberry + "/client.config") then
            bbFile = blackberry + "/client.config"
            File.open(blackberry + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        
        
        else
            File.open(blackberry + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        end
        if !File.directory? ios
            then
            puts "IOS missing"
            Dir.mkdir(themePath + "/ios")
        
        end
        if !File.exists?(ios + "/client.config") then
            iosFile = ios + "/client.config"
            File.open(ios + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        
        else
            File.open(ios + "/client.config", 'a') do |input|
                input.puts("\nshare_twitter_method=web\n")
            end
        end
    end
end
def checkin(brand)
    themePath = $home + "/mpp/media/#{brand}/_themes/global/"
    if File.directory? themePath then
        `svn add #{themePath}*`
        `svn ci #{themePath} -m "Adding share_method=web to #{brand} for android blackberry and ios"`
    end
end
    

#configInput("Tantao", "bizbal", "bizbuf")
for brand in getBrandList(adminUrl)
    checkin(brand)
end