require 'net/http'
require 'json'
require 'uri'

uri = URI.parse('https://kenkoooo.com/atcoder/resources/contest-problem.json')

begin
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    json_data = JSON.parse(response.body)

    File.open("problem.json", 'w') do |file|
      file.write(JSON.pretty_generate(json_data))
    end

    puts "JSONデータがproblem.jsonに正常に保存されました"
  else
    puts "データの取得に失敗しました。HTTPレスポンスコード:#{response.code}"
  end

rescue StandardError => e
  puts "エラーが発生しました：#{e.message}"
end
