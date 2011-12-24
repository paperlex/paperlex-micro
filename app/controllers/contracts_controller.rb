class ContractsController < ApplicationController
  before_filter :set_email
  
  def auth
    session[:email] = params[:email]
    
    redirect_to contract_url(params[:id])
  end
  
  def index
    @slaws = Paperlex::Slaw.all
  end
  
  def new
    @slaw_j = Paperlex::Slaw.find(params[:id])
    @slaw = RestClient.get("#{Paperlex.base_url}/slaws/#{params[:id]}.html?#{{:token => Paperlex.token, :enhanced => true}.to_query}").html_safe
  end
  
  def show
    @contract = Contract.find(:first, :conditions => ["uuid = ? AND (LOWER(email_1) = ? OR LOWER(email_2) = ?)", params[:id], @email, @email])
    
    if @contract.blank?
      return render(:action => :simple_auth)
    end
  end
  
  def create
    contract = Paperlex::Contract.create({:subject => params[:title], :number_of_signers => 2, :responses => params[:responses], :signature_callback_url => "#{CALLBACK_URL}/signature", :slaw_id => params[:slaw_id]})
    signer = contract.create_signer(:email => params[:email])
    review_session = contract.create_review_session(:email => params[:email])
    html_body = contract.to_html
    
    c = Contract.create(:email_1 => params[:email], :uuid => contract.uuid, :responses => params[:responses], :review_session_1 => review_session.uuid, :signer_1 => signer.uuid, :slaw_uuid => params[:slaw_id], :body => html_body, :title => params[:title])

    Notifications.new_contract(c).deliver

    session[:email] = params[:email]
    
    redirect_to contract_url(c.uuid)
  end
  
  def sign
    @contract = Contract.find(:first, :conditions => ["uuid = ? AND (LOWER(email_1) = ? OR LOWER(email_2) = ?)", params[:id], @email, @email])

    if @contract.blank?
      return render(:action => :simple_auth)
    end

    review_session_uuid = (@email == @contract.email_1.downcase ? @contract.review_session_1 : @contract.review_session_2)
    review_session = Paperlex::Contract.find(@contract.uuid).update_review_session(review_session_uuid, {:expires_in => 24.hours})

    redirect_to review_session.url
  end
  
  def invite
    @contract = Contract.find(:first, :conditions => ["uuid = ? AND (LOWER(email_1) = ? OR LOWER(email_2) = ?)", params[:id], @email, @email])
    if params[:email] == @contract.email_1 or params[:email].blank?
      return redirect_to(contract_url(@contract.uuid))
    end
    if @contract.blank?
      return render(:action => :simple_auth)
    end
    
    signer = Paperlex::Contract.find(@contract.uuid).create_signer(:email => params[:email])
    review_session = Paperlex::Contract.find(@contract.uuid).create_review_session(:email => params[:email])
    
    @contract.email_2 = params[:email]
    @contract.review_session_2 = review_session.uuid
    @contract.signer_2 = signer.uuid
    @contract.save
    
    Notifications.signature_request(@contract).deliver
    
    flash[:success] = "We just sent a signature request to #{params[:email]}"
    
    redirect_to contract_url(@contract.uuid)
  end
  
  private
  
  def set_email
    @email = session[:email].downcase rescue nil
  end
  
end