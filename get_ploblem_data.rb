require 'net/http'
require 'json'
require 'uri'
require 'csv'

def calculate_adjusted_difficulty(difficulty)
  if difficulty.nil?
    adjusted_diff = nil
  elsif difficulty <= 400
    adjusted_diff = (400 / (Math.exp((400 - difficulty) / 400.0)) + 0.5).to_i
  else
    adjusted_diff = difficulty
  end
  adjusted_diff
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
    File.open("problem.json", 'w') do |file|
      file.write(JSON.pretty_generate(problems_data))
    end

    # CSVデータの準備
    algo_data = CSV.read("db/csv_data/problem_to_algo.csv", headers: true)
    problem_ids = algo_data.map { |row| row[0] }
    
    problems_diff_uri = URI.parse('https://kenkoooo.com/atcoder/resources/problem-models.json')
    problems_diff_response = Net::HTTP.get_response(problems_diff_uri)
    problems_diff_data = JSON.parse(problems_diff_response.body)
    
    # CSVデータの生成
    csv_data = CSV.generate do |csv|
      csv << problems_data.first.keys.slice(..3).push("difficulty").push("algo_id")
      problems_data.each do |problem|
        diff = problems_diff_data[problem.values[0]]&.fetch("difficulty", nil)
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
    
    # CSVデータをファイルに書き込む
    File.open('db/csv_data/problem.csv', 'w') do |file|
      file.write(csv_data)
    end
    
    puts 'CSVファイルに保存しました。'
  else
    puts "データの取得に失敗しました。HTTPレスポンスコード:#{response.code}"
  end

rescue StandardError => e
  puts "エラーが発生しました：#{e.message}"
end
