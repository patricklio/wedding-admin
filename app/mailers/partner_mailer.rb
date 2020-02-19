class PartnerMailer < ApplicationMailer
    default :from => 'admin@mobility-sn.com'

    # send a signup email to the customer, pass in the customer_account object that contains the customer's email address and password
    def send_partner_creation_email(partner, random_password)
      @partner = partner
      @password = random_password
      mail( :to => @partner.email,
      :subject => 'Votre Compte kulucar' )
    end
end
