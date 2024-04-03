# frozen_string_literal: true

# GetproblemsControllerは、AtCoderの問題を取得するためのコントローラです。
class GetproblemsController < ApplicationController
  def top
    # セッションにアルゴリズムリストがない場合に初期化
    session[:algo_list] = Algo.pluck(:algo_name)

    return unless session[:selected_algo].present?

    name_to_id = Algo.where(algo_name: session[:selected_algo]).pluck(:algo_id).first
    @problems = Problem.where(algo_id: name_to_id) if name_to_id.present?
  end

  def random_problem
    # インスタンスを生成して問題を取得
    entry = GetProblem.new
    session[:res_data] = entry.response_problem(params)

    store_problem_info_in_session(session[:res_data])

    redirect_to root_path
  end

  def algo_problem
    # 選択されたアルゴリズムをセッションに保存
    session[:selected_algo] = params[:selecte_algo]

    redirect_to root_path
  end
end

private

def store_problem_info_in_session(res_data)
  return unless res_data.present?

  problem = res_data.first
  session[:contest_id] = problem['contest_id']
  session[:problem_id] = problem['id']
  session[:problem_index] = problem['problem_index']
end
