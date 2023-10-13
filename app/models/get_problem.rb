require 'json'

class GetProblem < ApplicationRecord
    def get_random_contest(parsed_data,a,b,c,d,e,f,g,ex)
        filtered_data = parsed_data.select do |problem|
            (a == 1 && problem["problem_index"] == "A") ||
            (b == 1 && problem["problem_index"] == "B") ||
            (c == 1 && problem["problem_index"] == "C") ||
            (d == 1 && problem["problem_index"] == "D") ||
            (e == 1 && problem["problem_index"] == "E") ||
            (f == 1 && problem["problem_index"] == "F") ||
            (g == 1 && problem["problem_index"] == "G") ||
            (ex == 1 && problem["problem_index"] == "Ex") 
        end

        if filtered_data.empty?
            return parsed_data.sample
        end

        random_problem = filtered_data.sample
        return random_problem
    end


    def resoponse_problem(a,b,c,d,e,f,g,ex)
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

        target_problem_id = get_random_contest(parsed_data,a,b,c,d,e,f,g,ex)


        # 指定したcontest_idに対応するproblem_idとproblem_indexを格納する配列
        result = []

        # データから指定したcontest_idに対応するproblem_idとproblem_indexを抽出

        parsed_data.each do |problem|
            if problem["problem_id"] == target_problem_id["problem_id"]
                result << problem
            end
        end

        # 結果を出力
        return result
    end
end
