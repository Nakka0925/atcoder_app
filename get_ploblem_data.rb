# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'
require 'csv'

def calculate_adjusted_difficulty(difficulty)
  if difficulty.nil?
    nil
  elsif difficulty <= 400
    ((400 / Math.exp((400 - difficulty) / 400.0)) + 0.5).to_i
  else
    difficulty
  end
end

# 問題データのURI
problems_json_uri = URI.parse('https://kenkoooo.com/atcoder/resources/merged-problems.json')

begin
  # 問題データの取得
  response = Net::HTTP.get_response(problems_json_uri)

  if response.is_a?(Net::HTTPSuccess)
    # JSONデータを取得
    problems_data = JSON.parse(response.body)

    # 問題データをproblem.jsonに保存
    File.write('problem.json', JSON.pretty_generate(problems_data))

    # CSVデータの準備
    algo_data = CSV.read('db/csv_data/problem_to_algo.csv', headers: true)
    problem_ids = algo_data.map { |row| row[0] }

    problems_diff_uri = URI.parse('https://kenkoooo.com/atcoder/resources/problem-models.json')
    problems_diff_response = Net::HTTP.get_response(problems_diff_uri)
    if problems_diff_response.is_a?(Net::HTTPSuccess)
      problems_diff_data = JSON.parse(problems_diff_response.body)
      File.write('difficulty.json', JSON.pretty_generate(problems_diff_data))
    else
      puts "データの取得に失敗しました。HTTPレスポンスコード:#{problems_diff_response.code}"
    end

    # CSVデータの生成
    csv_data = CSV.generate do |csv|
      csv << %w[problem_id contest_id problem_index name difficulty algo_id]
      problems_data.each do |problem|
        diff = problems_diff_data[problem.values[0]]&.fetch('difficulty', nil)
        diff = calculate_adjusted_difficulty(diff)
        matching_indices = problem_ids.each_index.select { |i| problem_ids[i] == problem.values[0] }

        if matching_indices.any?
          matching_indices.each do |idx|
            algo_id = algo_data[idx][1]
            csv << problem.values.slice(..3).push(diff).push(algo_id)
          end
        else
          csv << problem.values.slice(..3).push(diff).push(nil)
        end
      end
    end
  else
    puts "データの取得に失敗しました。HTTPレスポンスコード:#{response.code}"
  end
rescue StandardError => e
  puts "エラーが発生しました：#{e.message}"
end

# 既存の problem.csv データを読み込む
existing_csv_data = CSV.read('db/csv_data/problem.csv', headers: true)

# 新しく生成された csv_data を読み込む
new_csv_data = CSV.parse(csv_data, headers: true)

# 差分を格納する配列
differences = []

# existing_csv_data にあって new_csv_data にない行を探す
existing_csv_data.each do |existing_row|
  matching_row = new_csv_data.find { |new_row| new_row['problem_id'] == existing_row['problem_id'] }
  differences << existing_row if matching_row.nil?
end

# new_csv_data にあって existing_csv_data にない行を探す
new_csv_data.each do |new_row|
  matching_row = existing_csv_data.find { |existing_row| existing_row['problem_id'] == new_row['problem_id'] }
  differences << new_row if matching_row.nil?
end

# 差分をまとめるCSVファイルに書き込む
diff_csv_file_path = 'db/csv_data/differences.csv'
CSV.open(diff_csv_file_path, 'w', headers: true) do |csv|
  csv << existing_csv_data.headers # ヘッダーを書き込む
  differences.each do |row|
    csv << row
  end
end

puts "差分を #{diff_csv_file_path} ファイルに保存しました。"

# CSVデータをファイルに書き込む
File.write('db/csv_data/problem.csv', csv_data)

puts 'CSVファイルに保存しました。'
