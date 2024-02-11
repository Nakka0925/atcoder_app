class GetproblemsController < ApplicationController
  def top
    # セッションにアルゴリズムリストがない場合に初期化
    session[:algo_list] ||= Algo.pluck(:algo_name)
    
    if session[:selected_algo].present?
      name_to_id = Algo.where(algo_name: session[:selected_algo]).pluck(:algo_id).first
      @problems = Problem.where(algo_id: name_to_id) if name_to_id.present?
    end
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

    redirect_to root_path
  end
end