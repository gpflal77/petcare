class UsersController < ApplicationController
  def index
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
  end
    
  def sign_out
  end 
  
end
