class Admin::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /admin/customers
  def index
    @customers = Customer.all
  end

  # GET /admin/customers/1
  def show
  end

  # GET /admin/customers/new
  def new
    @customer = Customer.new
    if params[:request_id]
      request = InfoRequest.find(params[:request_id])
      if request
        @customer.company_name = request.company_name
        @customer.customer_type_id = CustomerType.business.first.id
        @customer.address = request.company_address
        @customer.phone_number = request.phone_number
        @customer.ninea = request.ninea
        @customer.firstname = request.firstname
        @customer.lastname = request.lastname
        @customer.email = request.working_email
      end
    end
  end

  # GET /admin/customers/1/edit
  def edit
  end

  # POST /admin/customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      create_default_customer_account(@customer)

      if params[:customer][:request_id]
        request = InfoRequest.find(params[:customer][:request_id])
        if request
          request.close(current_admin_user_account)
        end
      end

      if params[:commit] == "Enregistrer"
        redirect_to admin_customers_url, flash: { success: 'Les données ont bien été enregistrées.' }
      else
        redirect_to edit_admin_customer_path(@customer), flash: { success: "Les données ont bien été enregistrées." }
      end

    else
      render :new
    end
  end

  # PATCH/PUT /admin/customers/1
  def update
    if @customer.update(customer_params)
      redirect_to admin_customers_url, flash: { success: 'Le client est modifié avec succès' }
    else
      render :edit
    end
  end

  # DELETE /admin/customers/1
  def destroy
    @customer.destroy

    redirect_to admin_customers_url, flash: { success: 'Le client est supprimé avec succès' }
  end

  def create_customer_account
    customer_account = get_customer_account_object(params[:customer_user_account][:email],
                                                  params[:customer_user_account][:customer_id],'','')
    password = customer_account.password
    if customer_account.save
      CustomerMailer.send_account_creation_email(customer_account.email, password).deliver_later
      redirect_to edit_admin_customer_path(customer_account.customer), flash: { success: "Les données ont bien été enregistrées." }
    else
      redirect_to edit_admin_customer_path(params[:customer_user_account][:customer_id]), flash: { error: customer_account.errors.full_messages.to_sentence }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
    @accounts = @customer.customer_user_accounts
    @customer_user_account = CustomerUserAccount.new
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:company_name,
                                      :address,
                                      :phone_number,
                                      :ninea,
                                      :firstname,
                                      :lastname,
                                      :email,
                                      :customer_type_id
                                    )
  end

  def create_default_customer_account(customer)
    customer_account = get_customer_account_object(customer.email, customer.id,customer.firstname,customer.lastname)
    random_password = customer_account.password

    if customer_account.save
      CustomerMailer.send_account_creation_email(customer_account.email, random_password).deliver_later
    end
  end

  def get_customer_account_object(email, customer_id, firstname, lastname)
    random_password = SecureRandom.base36(8)
    encrypted_password = BCrypt::Password.create(random_password)

    customer_account = CustomerUserAccount.new(customer_id: customer_id,
                        password: random_password,
                        email: email,
                        encrypted_password: encrypted_password,
                        firstname: firstname,
                        lastname: lastname
                      )
    if params[:customer][:request_id]
      customer_account.info_request_id = params[:customer][:request_id].to_i
    end

    customer_account
  end
end
