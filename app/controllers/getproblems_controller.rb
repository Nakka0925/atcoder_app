class GetproblemsController < ApplicationController
  def top
    @algo_names = Algo.pluck(:algo_name)
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
    name_to_id = Algo.where(algo_name: params[:algo_test])[0][:algo_id]
    session[:algo] = Problem.where(algo_id: name_to_id).sample

    redirect_to root_path
  end
end