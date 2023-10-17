class ProblemsApiController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'

  def new
    url = URI.parse("https://kenkoooo.com/atcoder/resources/problems.json")
      response = Net::HTTP.get_response(url)

      @contestUrl = "https://atcoder.jp/contests"
      @contestTaskUrl = "https://atcoder.jp/contests/tasks"

      @responseJson = JSON.parse(response.body)
      @contestId = Hash.new { |h, k| h[k] = Array.new }
      @contestIdTitle = Hash.new { |h, k| h[k] = Hash.new(0)}

      @responseJson.each do |hash|
        @contestId[hash["contest_id"]] << hash["problem_index"]
        @contestIdTitle[hash["contest_id"]][hash["problem_index"]] = hash["title"]
      end

  end
end
