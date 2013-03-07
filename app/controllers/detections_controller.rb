require 'will_paginate/array'
require 'action_view/helpers/number_helper'
require 'csv'

class DetectionsController < ApplicationController

	include ActionView::Helpers::NumberHelper

	def new
		@detection = Detection.new
	end

	def show
		@detection = Detection.find(params[:id])

		@positive_keys = @detection.positive_training.keys
		@negative_keys = @detection.negative_training.keys
		
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
    			@detection.positive_training[pim.code] = [pid, (pim.dir + pim.name)]
    			#pim.trainings += 1
    			#pim.save
    		end

    		#build negative training set
    		@detection.negative_training = Hash.new

    		neg_ids.each do |nid|
    			nim = Negative.find(nid)
    			@detection.negative_training[nim.code] = [nid, (nim.dir + nim.name)]
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
    			tmpkeys << [pim.code, '1', (pim.dir + pim.name), eval_pos_ids[k]]
    			tmpkeys << [nim.code, '0', (nim.dir + nim.name), eval_neg_ids[k]]
    			#pim.detections += 1
    			#nim.detections += 1
    		end

    		tmpkeys.shuffle!

    		(0..tmpkeys.length-1).each do |j|
    			# key is CODE, value is an array made with id, type, name, detection, time
    			@detection.value[tmpkeys[j][0]] = [tmpkeys[j][3], tmpkeys[j][1], tmpkeys[j][2], 'u', 0]
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

		@positive_keys = @detection.positive_training.keys
		@negative_keys = @detection.negative_training.keys
		
		# NB: NOW IS ACCURACY
		f1den = @detection.tp + @detection.fn + @detection.fp + @detection.tn

		if f1den == 0
			@f1score = number_with_precision(0.0);
		else
			@f1score = number_with_precision( ( @detection.tp.to_f + @detection.tn.to_f ) / f1den.to_f * 100 )
		end

		sensden = @detection.tp + @detection.fn

		if sensden == 0
			@sensitivity = number_with_precision(0.0)
		else
			@sensitivity = number_with_precision( @detection.tp.to_f / sensden.to_f * 100 )
		end

		specden = @detection.tn + @detection.fp
		
		if specden == 0
			@specificity = number_with_precision(0.0)
		else
			@specificity = number_with_precision( @detection.tn.to_f / specden.to_f * 100 )
		end

		#@image_keys = @detection.value.keys.paginate(:page => params[:page], :per_page => 5)
		@curr_image_code = @detection.value.keys[@detection.currId]

		#save at beginning of test, to use "updated_at" as a time reference
		if @detection.currId == 0
			@detection.save
		end
	end

	def save
		act_t = Time.now
		@detection = Detection.find(params[:id])

		selected = false

		guess = 0

		curr_image_code = @detection.value.keys[@detection.currId]

		params.keys.each do |k|
			if !k["mit"].nil?
				# look for codeputs "PARAMS2 #{params}"
				puts "found submit"
				pim = Evalpositive.find_by_code(curr_image_code)
				
				if pim != nil
					# it is a positive image
					if !k['pp'].nil?
						selected = true
						guess = 1
						#it is detected as positive
						pim.positives += 1
						#update detection
						@detection.value[curr_image_code][3] = 1.0
						@detection.tp += 1
					elsif !k['qp'].nil?
						selected = true
						guess = 2
						#it is detected as positive
						pim.positives += 1
						#update detection
						@detection.value[curr_image_code][3] = 0.75
						@detection.tp += 1
					elsif !k['qn'].nil?
						selected = true
						guess = 3
						#update detection
						@detection.value[curr_image_code][3] = 0.25
						@detection.fn += 1
					elsif !k['nn'].nil?
						selected = true
						guess = 4
						#update detection
						@detection.value[curr_image_code][3] = 0.0
						@detection.fn += 1					
					end
					pim.save
					@detection.value[curr_image_code][4] = (act_t - @detection.updated_at).to_i
				else
					nim = Evalnegative.find_by_code(curr_image_code)

					if nim != nil
						# it is a negative image
						nim.detections += 1
						if !k['pp'].nil?
							selected = true
							guess = 5
							#it is detected as positive
							nim.positives += 1
							#update detection
							@detection.value[curr_image_code][3] = 1.0
							@detection.fp += 1
						elsif !k['qp'].nil?
							selected = true
							guess = 6
							#it is detected as positive
							nim.positives += 1
							#update detection
							@detection.value[curr_image_code][3] = 0.75
							@detection.fp += 1
						elsif !k['qn'].nil?
							selected = true
							guess = 7
							#update detection
							@detection.value[curr_image_code][3] = 0.25
							@detection.tn += 1
						elsif !k['nn'].nil?
							selected = true
							guess = 8
							#update detection
							@detection.value[curr_image_code][3] = 0.0
							@detection.tn += 1					
						end
						nim.save
						@detection.value[curr_image_code][4] = (act_t - @detection.updated_at).to_i
					end
				end
			end
		end

		#params[:pos_page] = params['cpp']
		#params[:neg_page] = params['cnp']

		if !selected
			flash[:warning] = "Please classify Image or press Finish"
			#redirect_to test_detection_path(@detection, :anchor => "samples")
			redirect_to test_detection_path(@detection)
		else
			case guess
				when 1
					flash[:success] = "Correct! last image was a Mitosis"
				when 2
					flash[:success] = "Your guess was right: last image was a Mitosis"
				when 3
					flash[:error] = "Your guess was wrong: last image was a Mitosis"
				when 4
					flash[:error] = "Sorry! last image was a Mitosis"
				when 5
					flash[:error] = "Sorry! last image was a NON Mitosis"
				when 6
					flash[:error] = "Your guess was wrong: last image was a NON Mitosis"
				when 7
					flash[:success] = "Your guess was right: last image was a NON Mitosis"
				when 8
					flash[:success] = "Correct! last image was a NON Mitosis"
			end

			@detection.currId += 1
			@detection.save

			if @detection.currId == @detection.value.values.length
				redirect_to results_detection_path(@detection)
			else
				redirect_to test_detection_path(@detection)
				#redirect_to test_detection_path(@detection, :anchor => "samples")
			end
		end

	end

	def results
		@detection = Detection.find(params[:id])


		#NB: NOW is ACCURACY
		f1den = @detection.tp + @detection.fn + @detection.fp + @detection.tn

		if f1den == 0
			@f1score = number_with_precision(0.0);
		else
			@f1score = number_with_precision( ( @detection.tp.to_f + @detection.tn.to_f ) / f1den.to_f * 100 )
		end

		sensden = @detection.tp + @detection.fn

		if sensden == 0
			@sensitivity = number_with_precision(0.0)
		else
			@sensitivity = number_with_precision( @detection.tp.to_f / sensden.to_f * 100 )
		end

		specden = @detection.tn + @detection.fp
		
		if specden == 0
			@specificity = number_with_precision(0.0)
		else
			@specificity = number_with_precision( @detection.tn.to_f / specden.to_f * 100 )
		end

	end

	def index
		detections = Detection.all

		@detectionsindex = Array.new

		detections.each do |d|

			case d.user
				when 1
					type = "newbie"
				when 2
					type = "biologist"
				when 3
					type = "histologist"
			end

			case d.sight
				when 1
					sight = "normal"
				when 2
					sight = "colorblind"
			end

			tot_time = 0

			d.value.values.each do |v|
				if !v[3].to_s["u"].nil?
					break
				else
					tot_time += v[4]
				end
			end

			tot_det = d.tp + d.tn + d.fp + d.fn

			if tot_time == 0
				avg = 0.0
			else
				avg = number_with_precision( tot_time.to_f / tot_det.to_f )
			end

					
			@detectionsindex << [d.code, type, sight, d.nickname, tot_det, d.tp, d.tn, d.fp, d.fn, avg, d.updated_at  ]
		end
	end

	def search
		# puts "PARAMS pippo #{params}"
		@detection = Detection.find_by_code(params[:code])

		if @detection.nil?
			flash[:error] = "No Detection found with code #{params[:code]}"
			redirect_to(root_path)
		else
			flash[:success] = "OK"
			redirect_to results_detection_path(@detection)
		end
	end

	def download

		detections = Detection.all

		csv = CSV.generate do |csv|
			detections.each do |d|
				csv << ["USER",d.user,d.sight,d.nickname,d.updated_at,d.tp,d.fn,d.tn,d.fp,d.code]
				d.value.values.each do |v|
					if !v[3].to_s["u"].nil?
						break
					else
						if v[1]['1'].nil?
							# neg image
							im = Evalnegative.find(v[0])
							tot_id = v[0] + Evalpositive.count
						elsif v[1]['0'].nil?
							#pos image
							im = Evalpositive.find(v[0])
							tot_id = v[0]
						else
							puts "unknown image"
							break;
						end

						csv << [tot_id,im.image.split('.')[0],im.x,im.y,v[1],v[3],v[4]]

					end
				end
			end
		end

		send_data csv, :type => 'text/csv', :filename => 'user.csv', :disposition => 'attachment'

		#redirect_to detections_path
	end

	def imagedownload

		csv = CSV.generate do |csv|

			ep = Evalpositive.all

			ep.each do |im|
				csv << [im.id,'1',im.image.split('.')[0],im.x,im.y,im.positives]
			end

			en = Evalnegative.all

			en.each do |im|
				csv << [im.id + Evalpositive.count,'0',im.image.split('.')[0],im.x,im.y,im.positives]
			end

		end

		send_data csv, :type => 'text/csv', :filename => 'images.csv', :disposition => 'attachment'

	end

	def comment
		@detection = Detection.find(params[:id])
	end

	def commentsave
		@detection = Detection.find(params[:id])
		#save comments
		@detection.comment = params[:comment][:text]
		@detection.save
		redirect_to results_detection_path(@detection)
	end

	def comments
		detections = Detection.all

		@comments = Array.new

		detections.each do |d|

			case d.user
				when 1
					type = "newbie"
				when 2
					type = "biologist"
				when 3
					type = "histologist"
			end

			case d.sight
				when 1
					sight = "normal vision"
				when 2
					sight = "colorblind"
			end

			if d.nickname.empty?
				nick = "Anonymous"
			else
				nick = d.nickname
			end

			if !d.comment.nil?
				@comments << [nick, type, sight, d.comment, d.updated_at  ]
			end
		end
	end
end
