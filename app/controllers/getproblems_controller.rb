class GetproblemsController < ApplicationController
  def top
  end

  def create
    entry = GetProblem.new()
    session[:res_data] = entry.resoponse_problem()
    session[:contest_id] = session[:res_data][0]["contest_id"]
    session[:problem_id] = session[:res_data][0]["problem_id"]
    session[:problem_index] = session[:res_data][0]["problem_index"]
    redirect_to root_path
  end
end