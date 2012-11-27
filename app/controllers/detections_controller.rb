class DetectionsController < ApplicationController
  def new
  	@detection = Detection.new
  end

  def show
  	@detection = Detection.find(params[:id])
  end
end
