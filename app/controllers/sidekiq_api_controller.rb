class SidekiqApiController < ApplicationController
  def index
    render json: Sidekiq::Stats.new
  end
end
