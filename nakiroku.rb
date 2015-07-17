#!/usr/bin/env ruby

require 'twitter'
require 'fileutils'

HISTORY_FILE        = 'twitter_name_history.txt'
TWITTER_SCREEN_NAME = 'pecosantoyobe'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

my_name = client.user(TWITTER_SCREEN_NAME).name

FileUtils.touch(HISTORY_FILE) unless File.exist?(HISTORY_FILE)

open(HISTORY_FILE, 'r+') do |io|
  unless io.gets.to_s.strip == my_name
    io.rewind
    io.puts "#{my_name}\n#{open(HISTORY_FILE).read}"
  end
end
