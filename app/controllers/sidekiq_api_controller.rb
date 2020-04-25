class SidekiqApiController < ApplicationController
  respond_to :json

  def index
    respond_with Sidekiq::Stats.new
  end
end
