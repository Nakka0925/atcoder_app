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

(200..230).each do |i|
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

  urls.each do |edi_url|
    p edi_url
    sleep(4)
    edi_html = URI.open(edi_url)
    doc = Nokogiri::HTML(edi_html)
    problem_index_url = String.new
    edi_pattern = %r{/contests/abc#{i}/tasks/}

    doc.css('a').each do |link|
      href = link['href']
      problem_index_url = href if href&.match?(edi_pattern)
    end

    doc.css('p').each do |paragraph| # <p>タグのテキスト内容を取得し、両端の空白を削除
      content = paragraph.text.strip
      # アルゴリズムデータの各パターンに対して処理を行う
      algo_data.each do |pattern_str, value|
        next unless content.include?(pattern_str)

        contest_to_algo << [problem_index_url[-8..], value]
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

File.write('test.csv', csv_data)
