require 'will_paginate/array'

class DetectionsController < ApplicationController

	def new
		@detection = Detection.new
	end

	def show
		@detection = Detection.find(params[:id])

		@positive_keys = @detection.positive_training.keys.paginate(:page => params[:pos_page], :per_page => 24)
		@negative_keys = @detection.negative_training.keys.paginate(:page => params[:neg_page], :per_page => 24)
		
		if params[:pos_page].nil?
			@curr_pos_page = 1
		else
			@curr_pos_page = params[:pos_page].to_i
		end

		if params[:neg_page].nil?
			@curr_neg_page = 1
		else
			@curr_neg_page = params[:neg_page].to_i
		end
		
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
    		# flash[:success] = "Welcome to the training phase!"

    		#shuffle positive and select same number of negatives for training
    		pos_ids = (1..Positive.count).to_a.shuffle
    		neg_ids = (1..Negative.count).to_a.shuffle[0..Positive.count-1]

    		# build positive training set
    		@detection.positive_training = Hash.new

    		pos_ids.each do |pid|
    			pim = Positive.find(pid)
    			@detection.positive_training[pim.code] = [pid, ('training/' + pim.dir + pim.name)]
    			#pim.trainings += 1
    			#pim.save
    		end

    		#build negative training set
    		@detection.negative_training = Hash.new

    		neg_ids.each do |nid|
    			nim = Negative.find(nid)
    			@detection.negative_training[nim.code] = [nid, ('training/' + nim.dir + nim.name)]
    			#nim.trainings += 1
    			#nim.save
    		end

    		#build test set
    		tmpkeys = Array.new

    		#shuffle positive and select same number of negatives for detection
    		eval_pos_ids = (1..Evalpositive.count).to_a.shuffle
    		eval_neg_ids = (1..Evalnegative.count).to_a.shuffle[0..Evalpositive.count-1]

    		(0..Evalpositive.count-1).each do |k|
    			pim = Evalpositive.find(eval_pos_ids[k])
    			nim = Evalnegative.find(eval_neg_ids[k])
    			tmpkeys << [pim.code, '1', ('evaluation/' + pim.dir + pim.name), eval_pos_ids[k]]
    			tmpkeys << [nim.code, '0', ('evaluation/' + nim.dir + nim.name), eval_neg_ids[k]]
    			#pim.detections += 1
    			#nim.detections += 1
    		end

    		tmpkeys.shuffle!

    		(0..tmpkeys.length-1).each do |j|
    			# key is CODE, value is an array made with id, type, name, detection
    			@detection.value[tmpkeys[j][0]] = [tmpkeys[j][3], tmpkeys[j][1], tmpkeys[j][2], 'u']
    		end

			@detection.tp = 0
			@detection.tn = 0
			@detection.fp = 0
			@detection.fn = 0

			@detection.currId = 0

    		@detection.save

      		redirect_to @detection
    	else
			render 'new'
		end
	end

	def test
		@detection = Detection.find(params[:id])

		@positive_keys = @detection.positive_training.keys.paginate(:page => params[:pos_page], :per_page => 18)
		@negative_keys = @detection.negative_training.keys.paginate(:page => params[:neg_page], :per_page => 18)
		
		if params[:pos_page].nil?
			@curr_pos_page = 1
		else
			@curr_pos_page = params[:pos_page].to_i
		end

		if params[:neg_page].nil?
			@curr_neg_page = 1
		else
			@curr_neg_page = params[:neg_page].to_i
		end

		@f1score = 0.0;
		#@image_keys = @detection.value.keys.paginate(:page => params[:page], :per_page => 5)
		@curr_image_code = @detection.value.keys[@detection.currId]
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
