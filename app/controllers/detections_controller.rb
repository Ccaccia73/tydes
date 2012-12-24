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
		
		@detection.positive_training = Hash.new
		pos_ids.each do |pid|
			pim = Positive.find(pid)
			@detection.positive_training[pim.code] = [pid, (pim.dir + pim.name)]
			#pim.trainings += 1
			#pim.save
		end

		@detection.negative_training = Hash.new

		neg_ids.each do |nid|
			nim = Negative.find(nid)
			@detection.negative_training[nim.code] = [nid, (nim.dir + nim.name)]
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

		@positive_images = @detection.positive_training
		@negative_images = @detection.negative_training
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

		@detection.tp = 0
		@detection.tn = 0
		@detection.fp = 0
		@detection.fn = 0

    	if @detection.save
    		# flash[:success] = "Welcome to the training phase!"
      		redirect_to @detection
    	else
			render 'new'
		end
	end

	def test
		@detection = Detection.find(params[:id])
		@images = @detection.value
		#@image_keys = @detection.value.keys.paginate(:page => params[:page], :per_page => 5)
		@image_keys = @detection.value.keys
	end

	def save
		@detection = Detection.find(params[:id])

		params.keys.each do |k|
			if k.length == 9
				# look for code
				pim = Positive.find_by_code(k)
				
				if pim != nil
					# it is a positive image
					pim.detections += 1
					if params[k] == 'p'
						#it is detected as positive
						pim.positives += 1
						#update detection
						@detection.value[k][3] = 'tp'
						@detection.tp += 1
					elsif params[k] == 'n'
						#update detection
						@detection.value[k][3] = 'fn'
						@detection.fn += 1
					end
					pim.save
				else
					nim = Negative.find_by_code(k)

					if nim != nil
						# it is a negative image
						nim.detections += 1
						if params[k] == 'p'
							#it is detected as positive
							nim.positives += 1
							#update detection
							@detection.value[k][3] = 'fp'
							@detection.fp += 1
						elsif params[k] == 'n'
							#update detection
							@detection.value[k][3] = 'tn'
							@detection.tn += 1
						end
						nim.save
					end
				end
			end
		end

		#update trainings
		@detection.positive_training.keys.each do |k|
			pim = Positive.find_by_code(k)
			pim.trainings += 1
			pim.save
		end

		@detection.negative_training.keys.each do |k|
			nim = Negative.find_by_code(k)
			nim.trainings += 1
			nim.save
		end


		@detection.save
		redirect_to results_detection_path(@detection)
	end

	def results
		puts "PARAMS2 #{params}"
		@detection = Detection.find(params[:id])
	end

end
