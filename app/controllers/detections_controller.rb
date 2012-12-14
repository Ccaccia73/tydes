require 'will_paginate/array'

class DetectionsController < ApplicationController

	def new
		@detection = Detection.new
	end

	def show
		@detection = Detection.find(params[:id])


		all_pos_ids = (1..Positive.count).to_a.shuffle[0..49]
		all_neg_ids = (1..Negative.count).to_a.shuffle[0..49]
		
		pos_ids = all_pos_ids[0..24]
		neg_ids = all_neg_ids[0..24]
		
		@detection.trainingset = pos_ids + neg_ids

		@positives = Hash.new
		pos_ids.each do |pid|
			pim = Positive.find(pid)
			@positives[pim.code] = [pid, (pim.dir + pim.name)]
			#pim.trainings += 1
			#pim.save
		end

		@negatives = Hash.new

		neg_ids.each do |nid|
			nim = Negative.find(nid)
			@negatives[nim.code] = [nid, (nim.dir + nim.name)]
			#nim.trainings += 1
			#nim.save
		end

		tmpkeys = Array.new

		(25..49).each do |k|
			pim = Positive.find(all_pos_ids[k])
			nim = Negative.find(all_neg_ids[k])
			tmpkeys << [pim.code, 't', (pim.dir + pim.name), all_pos_ids[k]]
			tmpkeys << [nim.code, 'f', (nim.dir + nim.name), all_neg_ids[k]]
			#pim.detections += 1
			#nim.detections += 1
		end

		tmpkeys.shuffle!

		(0..tmpkeys.length-1).each do |j|
			# key is CODE, value is an array made with id, type, name, detection
			@detection.value[tmpkeys[j][0]] = [tmpkeys[j][3], tmpkeys[j][1], tmpkeys[j][2], 'u']
		end

		@detection.save

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

	def test
		@detection = Detection.find(params[:id])
		@images = @detection.value
		@image_keys = @detection.value.keys.paginate(:page => params[:page], :per_page => 5)
	end

end
