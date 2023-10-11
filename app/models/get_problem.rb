require 'json'

class GetProblem < ApplicationRecord
    def get_random_contest()
        file_path = '/atcoder_app/contest.json'

        json_data = File.read(file_path)
        parsed_data = JSON.parse(json_data)
        
        return parsed_data.sample
    end


    def resoponse_problem()
        file_path = "problem.json"

        begin
            # ファイルを開いてJSONをパース
            json_data = File.read(file_path)
            parsed_data = JSON.parse(json_data)

            # パースしたデータを使用する処理を記述
        rescue Errno::ENOENT => e
            # ファイルが見つからない場合のエラーハンドリング
            puts "Error: #{e.message}"
        rescue JSON::ParserError => e
            # JSONのパースエラーが発生した場合のエラーハンドリング
            puts "Error parsing JSON: #{e.message}"
        end

        target_problem_id = get_random_contest()

        # 指定したcontest_idに対応するproblem_idとproblem_indexを格納する配列
        result = []

        # データから指定したcontest_idに対応するproblem_idとproblem_indexを抽出

        parsed_data.each do |problem|
            if problem["problem_id"] == target_problem_id
                result << problem
            end
        end

        # 結果を出力
        return result
    end
end
