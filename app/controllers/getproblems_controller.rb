class GetproblemsController < ApplicationController
  def top
    # セッションにアルゴリズムリストがない場合に初期化
    session[:algo_list] ||= Algo.pluck(:algo_name)
  end

  def random_problem
     # インスタンスを生成して問題を取得
    entry = GetProblem.new
    session[:res_data] = entry.response_problem(params)

    if session[:res_data].present?
      problem = session[:res_data][0]
      session[:contest_id] = problem["contest_id"]
      session[:problem_id] = problem["id"]
      session[:problem_index] = problem["problem_index"]
    end

    redirect_to root_path
  end

  def algo_problem
    # 選択されたアルゴリズムをセッションに保存
    session[:selected_algo] = params[:selecte_algo]

    name_to_id = Algo.where(algo_name: params[:selecte_algo])[0][:algo_id]
    if name_to_id.present?
      session[:algo] = Problem.where(algo_id: name_to_id.algo_id).sample
    else
      flash[:error] = "選択されたアルゴリズムが見つかりません。"
    end

    redirect_to root_path
  end
end