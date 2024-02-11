# frozen_string_literal: true

# ProblemsApiController は問題に関するAPIエンドポイントを提供します。
# このコントローラは、問題の取得や作成、更新、削除などの操作を処理します。
class ProblemsApiController < ApplicationController
  require 'json'

  def new
    load_data
  end

  private

  # JSONデータを読み込み、レスポンスデータを処理します。
  def load_data
    @response_json = load_json_data('problem.json')
    @id_to_algoname = load_algo_id_to_name
    @contest_id_to_algo = load_contest_id_to_algo
    process_response_data
  end

  # JSONデータを読み込みます。
  def load_json_data(file_path)
    JSON.parse(File.read(file_path))
  rescue Errno::ENOENT => e
    puts "Error: #{e.message}"
    {}
  end

  # アルゴリズムIDをアルゴリズム名に変換するハッシュを取得します。
  def load_algo_id_to_name
    Algo.pluck(:algo_id, :algo_name).to_h
  end

  # コンテストIDをアルゴリズムIDの配列に変換するハッシュを取得します。
  def load_contest_id_to_algo
    Problem.group(:problem_id).pluck(:problem_id,
                                     Arel.sql('GROUP_CONCAT(algo_id) as algo_ids')).to_h.transform_values do |algo_ids|
      algo_ids&.split(',')&.map(&:to_i) || []
    end
  end

  # レスポンスデータを処理します。
  def process_response_data
    initialize_contest_variables
    process_contest_data
  end

  # コンテスト関連の変数を初期化します。
  def initialize_contest_variables
    @contest_url = 'https://atcoder.jp/contests'
    @contest_task_url = 'https://atcoder.jp/contests/tasks'
    @contest_id = Hash.new { |h, k| h[k] = [] }
    @contest_id_title = Hash.new { |h, k| h[k] = Hash.new(0) }
  end

  # コンテストデータを処理します。
  def process_contest_data
    @response_json.each do |hash|
      @contest_id[hash['contest_id']] << hash['problem_index']
      @contest_id_title[hash['contest_id']][hash['problem_index']] = hash['title']
    end
  end
end
