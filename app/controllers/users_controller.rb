class UsersController < ApplicationController
  def index
  end

  def create
      user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], location: params[:location], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
      if user.valid?
          user.save
          flash[:notices] = ["Congrats, you have successfully registered, now you can log in!"]
          redirect_to "/"
      else
          flash[:errors] = user.errors.full_messages
          redirect_to "/"
      end
  end

  def edit
      @user = current_user
  end

  def update
      user = current_user
      user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], location: params[:location], state: params[:state])
      if user.valid?
          session[:name] = user.first_name
          flash[:notices] = ["You have successfully UPDATED your profile!"]
          redirect_to "/events"
      else
          flash[:errors] = user.errors.full_messages
          redirect_to "/users/#{session[:user_id]}/edit"
      end
  end

end
