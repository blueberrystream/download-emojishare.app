#!/bin/env ruby

require 'open-uri'
require 'json'
require 'cgi'

URL = 'https://script.googleusercontent.com/macros/echo?user_content_key=-fwh9D0w3iiProf3-03f9kL9Hm0dx-EOpghByr6PvfKbNlfDu6d0SlratdPhWstEyHbVYT4GLxgCwMqxLyEkjt-ikKcHuJ_Mm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnCEeSUn1yHcnfHXe6Xpy0tU9NY3WcuoUNGw_1vIKqyYzZpGAgtZuEVh7WyxDRW6OaScfNc2fO4hD&lib=MAS1h0prr6lBqor56IqwT6jd29UFmgB_N'.freeze
json = OpenURI.open_uri(URL).read
json = JSON.parse json

dir = 'downloads'
Dir.mkdir dir unless Dir.exist? dir

json['data'].each do |data|
  uri = data['url']
  name = uri.match(%r{https://emoji.slack-edge.com/.*?/(.*?)/.*?})[1]
  name = CGI.unescape name
  ext = File.extname uri
  File.binwrite dir + '/' + name + ext, OpenURI.open_uri(uri).read
end
