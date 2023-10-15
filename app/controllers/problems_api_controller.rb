class ProblemsApiController < ApplicationController
  require 'httpclient'

  def new
    client = HTTPClient.new
    url = "https://kenkoooo.com/atcoder/resources/contests.json"
    @response = client.get(url)
    @responseJson = JSON.parse(@response.body)
  end
end
