class GetproblemsController < ApplicationController
  def top
    if session[:algo_list] == nil
      session[:algo_list] = Algo.pluck(:algo_name)
    end
  end

  def random_problem
    entry = GetProblem.new()

    session[:res_data] = entry.resoponse_problem(params)
    session[:contest_id] = session[:res_data][0]["contest_id"]
    session[:problem_id] = session[:res_data][0]["id"]
    session[:problem_index] = session[:res_data][0]["problem_index"]
    redirect_to root_path
  end

  def algo_problem
    session[:selected_algo] = params[:selecte_algo]
    name_to_id = Algo.where(algo_name: params[:selecte_algo])[0][:algo_id]
    session[:algo] = Problem.where(algo_id: name_to_id).sample

    redirect_to root_path
  end
end