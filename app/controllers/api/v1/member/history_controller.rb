class Api::V1::Member::HistoryController < ApplicationController
  before_action :authorized_member

  def index
    render json: @user.loan.order(:created_at), status: 200
  end
end
