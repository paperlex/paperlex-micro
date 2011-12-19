class Contract < ActiveRecord::Base
  has_many :signatures
  serialize :responses
  
  def signed?
    return true if self.signatures.count == 2
    return false
  end
  
  def signed_by?(email)
    if email == self.email_1
      return true if self.signatures.find_by_signer_uuid(self.signer_1)
    elsif email == self.email_2
      return true if self.signatures.find_by_signer_uuid(self.signer_2)
    else
      return false
    end
    return false
  end
  
end
