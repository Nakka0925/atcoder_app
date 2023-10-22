require 'net/http'
require 'json'
require 'uri'
require 'csv'

uri = URI.parse('https://kenkoooo.com/atcoder/resources/merged-problems.json')

begin
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    json_data = JSON.parse(response.body)

    File.open("problem.json", 'w') do |file|
      file.write(JSON.pretty_generate(json_data))
    end

    puts "JSONデータがproblem.jsonに正常に保存されました"
    algo = CSV.read("db/csv_data/problem_to_algo.csv",headers: true)
    problem_id = []
    
    algo.each do |ary|
      problem_id.push(ary[0])
    end
    
    csv_data = CSV.generate do |csv|
      # ヘッダー行を追加
      csv << json_data.first.keys.slice(..3).push("algo_id")
      # データ行を追加
      json_data.each do |hash|
        idx = problem_id.index(hash.values[0])
        if idx != nil
          csv << hash.values.slice(..3).push(algo[idx][1])
        else
          csv << hash.values.slice(..3).push(nil)
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
