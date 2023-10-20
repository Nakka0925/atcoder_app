class ProblemsApiController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'

  def new
      file_path = "problem.json"

      @contestUrl = "https://atcoder.jp/contests"
      @contestTaskUrl = "https://atcoder.jp/contests/tasks"

      json_data = File.read(file_path)
      @responseJson = JSON.parse(json_data)
      @contestId = Hash.new { |h, k| h[k] = Array.new }
      @contestIdTitle = Hash.new { |h, k| h[k] = Hash.new(0)}

      @responseJson.each do |hash|
        @contestId[hash["contest_id"]] << hash["problem_index"]
        @contestIdTitle[hash["contest_id"]][hash["problem_index"]] = hash["title"]
      end

  end
end
