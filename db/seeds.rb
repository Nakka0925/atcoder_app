require 'csv'

# CSVファイルのパスを指定
csv_file_path = Rails.root.join('db/csv_data/algo.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
    Algo.create!(
        algo_id: row["algo_id"],
        algo_name: row["algo_name"]
    )

csv_file_path = Rails.root.join('db/csv_data/problem.csv')

# CSVファイルを読み込んでデータベースに保存
CSV.foreach(csv_file_path, headers: true) do |row|
    Problem.create!(
        id: row["id"],
        contest_id: row["contest_id"],
        problem_index: row["problem_index"],
        name: row["name"],
        difficulty: row["difficulty"],
        algo_id: row["algo_id"]
    )
end