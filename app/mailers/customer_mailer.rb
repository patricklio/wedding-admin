class CustomerMailer < ApplicationMailer
  default :from => 'admin@mobility-sn.com'

  # send a signup email to the customer, pass in the customer_account object that contains the customer's email address and password
  def send_account_creation_email(email, random_password)
    @email = email
    @password = random_password
    mail( :to => @email,
    :subject => 'Votre Compte kulucar' )
  end
end
