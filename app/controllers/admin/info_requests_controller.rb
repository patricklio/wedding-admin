class Admin::InfoRequestsController < ApplicationController

  def index
    @opened_requests = InfoRequest.opened
    @closed_requests = InfoRequest.closed.include_user_firstname_lastname
  end
end
