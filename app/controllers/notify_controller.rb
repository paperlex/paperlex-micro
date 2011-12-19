class NotifyController < ApplicationController
  
  def add_email
    InterestedPerson.create(:email => params[:email])
    flash[:thanks] = "Thanks! We'll e-mail you when we add new contracts."
    redirect_to("/")
  end
  
end
