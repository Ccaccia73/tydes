class DetectionsController < ApplicationController
	def new
		@detection = Detection.new
	end

	def show
		@detection = Detection.find(params[:id])
	end

	def create
		@detection = Detection.new(params[:detection])

		begin
			tmp = (0..4).map{65.+(rand(26)).chr}.join
			[1,3].each do |k|
				tmp[k] = (1+rand(9)).to_s
			end
		end while (Detection.find_by_code(tmp))

		@detection.code = tmp

    	if @detection.save
    		flash[:success] = "Welcome to the training phase!"
      		redirect_to @detection
    	else
			render 'new'
		end
	end
end
