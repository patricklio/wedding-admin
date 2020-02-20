class Admin::DashboardController < ApplicationController
  def index
    @partners = Partner.all
    @customers = Customer.all
    @requests = InfoRequest.all
  end
end
