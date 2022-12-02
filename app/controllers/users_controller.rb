class UsersController < ApplicationController
  def new
  end

  def show
    puts '=============='
    p params
    puts '=============='
    @user = User.find(params[:id])
  end
end
