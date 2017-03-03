require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = 'http://theurlofthepage.com'
doc = Nokogiri::HTML(open(url))
status = doc.css('.status').first.content

# XML parsing

doc = Nokogiri::XML(open(url))

# using rest-client gem

require 'rest_client'

RestClient.get 'http://example.com/resource'
RestClient.post 'http://example.com/resource',
                param1: 'one',
                nested: { param2: 'two' }
RestClient.delete 'http://example.com/resource'
