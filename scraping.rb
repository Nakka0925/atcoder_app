# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'csv'

algo_data = {}
contest_to_algo = Set.new

CSV.foreach('db/csv_data/algo.csv', headers: true) do |row|
  algo_data[row[1]] = row[0]
end

# Todo データを逐次的に保存するようにする
(200..300).each do |i| # Note 例:ABC200-300 (200..300) ※あまり範囲を大きくすると通信エラーが出る場合がある
  url = "https://atcoder.jp/contests/abc#{i}/editorial?lang=ja" 

  html = URI.open(url)
  doc = Nokogiri::HTML(html)

  pattern = %r{/contests/abc#{i}/editorial/}

  urls = []

  # 各リンク要素をチェック
  doc.css('a').each do |link|
    href = link['href']
    # 正規表現に合致する場合、配列に追加
    urls << "https://atcoder.jp#{href}" if href&.match?(pattern)
  end

  urls.each do |url_per_index|
    sleep(2)
    html_per_index = URI.open(url_per_index)
    doc_per_index = Nokogiri::HTML(html_per_index)
    problem_url = String.new
    pattern_per_index = %r{/contests/abc#{i}/tasks/}

    doc_per_index.css('a').each do |link|
      href = link['href']
      problem_url = href if href&.match?(pattern_per_index)
    end

    doc_per_index.css('p').each do |paragraph| # <p>タグのテキスト内容を取得し、両端の空白を削除
      content = paragraph.text.strip
      # アルゴリズムデータの各パターンに対して処理を行う
      algo_data.each do |pattern_str, value|
        next unless content.include?(pattern_str)

        contest_to_algo << [problem_url[-8..], value]
      end
    end
  end
end

csv_data = CSV.generate do |csv|
  csv << %w[problem_id algo_id]
  contest_to_algo.each do |contest, algo|
    csv << [contest, algo]
  end
end

File.write('db/csv_data/problem_to_algo.csv.csv', csv_data)
