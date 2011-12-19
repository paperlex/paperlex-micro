class SignatureController < ApplicationController
  
  def create_signature
    contract = Contract.find_by_uuid(params[:contract_uuid])
    Signature.create(:contract => contract, :contract_uuid => params[:contract_uuid], :signature_uuid => params[:signature_uuid], :signer_uuid => params[:signer_uuid], :identity_verification_method => params[:identity_verification_method], :identity_verification_value => params[:identity_verification_value], :callback_signature_created_at => params[:callback_signature_created_at])

    if contract.signer_1 == params[:signer_uuid]
      Notifications.new_signature(contract, contract.email_1, contract.email_2).deliver
    else
      Notifications.new_signature(contract, contract.email_2, contract.email_1).deliver
    end
    
    if Signature.count(:conditions => {:contract_id => contract.id}) == 2
      Notifications.contract_signed(contract).deliver
    end
    
    render :nothing => true
  end
  
end
