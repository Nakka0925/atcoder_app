class GetproblemsController < ApplicationController
  def top
  end

  def create
    entry = GetProblem.new()
    a = params[:a].to_i
    b = params[:b].to_i
    c = params[:c].to_i
    d = params[:d].to_i
    e = params[:e].to_i
    f = params[:f].to_i
    g = params[:g].to_i
    ex = params[:ex].to_i


    session[:res_data] = entry.resoponse_problem(a,b,c,d,e,f,g,ex)
    session[:contest_id] = session[:res_data][0]["contest_id"]
    session[:problem_id] = session[:res_data][0]["problem_id"]
    session[:problem_index] = session[:res_data][0]["problem_index"]
    redirect_to root_path
  end
end