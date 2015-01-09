#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'json'

# Get all the constituency campaigns for Yorkshire and North Lincs
def get_constituencies
  Nokogiri::HTML(open("https://www.indiegogo.com/individuals/9515128/campaigns"))
    .css('li.i-profile-list-item')
    .collect do |item|
      [item.css('a.i-primary-image').attr('href'),
       item.css('div.i-tagline').first.content.match(/parliamentary candidate in\s+(.*)/)[1]]
  end
end

# For a given constituency path, get its current funding from indiegogo
def get_funding(constituency)
  Nokogiri::HTML(open("https://www.indiegogo.com"+ constituency))
    .css('div.i-balance .currency span').first
    .content.match(/\d+/)[0].to_i
end

funding = {}
get_constituencies.each do |tuple|
  name = tuple[1]
  funding[name] = get_funding(tuple[0])
end

puts funding.to_json
