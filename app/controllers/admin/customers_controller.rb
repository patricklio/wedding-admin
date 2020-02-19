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
  end

  # GET /admin/customers/1/edit
  def edit
  end

  # POST /admin/customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to admin_customers_url, flash: { success: 'Le client est créé avec succès.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
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
end
