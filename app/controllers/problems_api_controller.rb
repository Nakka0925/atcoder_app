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

      # アルゴリズムIDをキーとしてアルゴリズム名を取得するハッシュを作成
      @idToAlgoname ||= Algo.pluck(:algo_id, :algo_name).to_h

      # コンテストIDをキーとして、関連するアルゴリズムIDの配列を取得するハッシュを作成
      @contestIdToAlgo ||= load_contest_id_to_algo

      @contestId = Hash.new { |h, k| h[k] = Array.new }
      @contestIdTitle = Hash.new { |h, k| h[k] = Hash.new(0)}

      @responseJson.each do |hash|
        @contestId[hash["contest_id"]] << hash["problem_index"]
        @contestIdTitle[hash["contest_id"]][hash["problem_index"]] = hash["title"]
      end
  end
  
  private

  # アルゴリズムIDを配列として作成
  def load_contest_id_to_algo
    Problem.group(:problem_id).pluck(:problem_id, Arel.sql('GROUP_CONCAT(algo_id) as algo_ids')).to_h.transform_values do |algo_ids|
      algo_ids&.split(',')&.map(&:to_i) || []
    end
  end
end
