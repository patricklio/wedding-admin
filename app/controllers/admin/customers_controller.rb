class Admin::CustomersController < ApplicationController
  before_action :set_admin_customer, only: [:show, :edit, :update, :destroy]

  # GET /admin/customers
  # GET /admin/customers.json
  def index
    @customers = Customer.all
  end

  # GET /admin/customers/1
  # GET /admin/customers/1.json
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
  # POST /admin/customers.json
  def create
    @customer = Customer.new(admin_customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/customers/1
  # PATCH/PUT /admin/customers/1.json
  def update
    respond_to do |format|
      if @customer.update(admin_customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/customers/1
  # DELETE /admin/customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_customer_params
      params.require(:admin_customer).permit(:company_name, :address, :phone_number, :ninea, :firstname, :lastname, :email)
    end
end
