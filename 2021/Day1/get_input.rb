#!/usr/bin/env ruby

require "dotenv/load"
require "ruby_jard"

input_file = File.join(__dir__, "input.txt")

unless File.exist? input_file
  require "http"

  path = __dir__.split("/")
  year = path[-2]
  day = path[-1].gsub("Day", "")
  uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")
  response = HTTP.cookies(session: ENV["AOC_SESSION"]).get(uri)
  File.write(input_file, response.body)
end
