class Notifications < ActionMailer::Base
  default :from => "Paperlex Micro <paperlex@paperlex.com>"
  
  def new_contract(contract)
    @contract = contract
    mail(:to => contract.email_1, :subject => "Your new contract on Paperlex Micro")
  end
  
  def signature_request(contract)
    @contract = contract
    mail(:to => contract.email_2, :subject => "Signature request from Paperlex Micro")    
  end
  
  def new_signature(contract, signer_email, deliver_email)
    @contract = contract
    @signer_email = signer_email
    mail(:to => deliver_email, :subject => "Contract signed on Paperlex Micro")
  end
  
  def contract_signed(contract)
    @contract = contract
    mail(:to => [contract.email_1, contract.email_2], :subject => "Contract completed on Paperlex Micro")    
  end
  
end
