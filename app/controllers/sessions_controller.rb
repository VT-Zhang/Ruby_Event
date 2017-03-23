class SessionsController < ApplicationController

  def create
      if user = User.find_by(email: params[:email])
          if user.try(:authenticate, params[:password]) == false
              flash[:errors] = ["Invalid Password/Email Combination, Please try again."]
              redirect_to "/"
          else
              session[:user_id] = user.id
              session[:name] = user.first_name
              session[:state] = user.state
              redirect_to "/events"
          end
      else
          flash[:errors] = ["The user does not exist, please register."]
          redirect_to "/"
      end
  end

  def destroy
      reset_session
      redirect_to "/"
  end
end
