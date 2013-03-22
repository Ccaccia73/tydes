# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_file_path = "#{Rails.root}/db/seed_data/train_positives.csv"

#puts(csv_file_path)

if Positive.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Positive.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5]					
			}
		)

	end
	puts('done migrating TRAIN positive images')
end

csv_file_path = "#{Rails.root}/db/seed_data/train_negatives.csv"

if Negative.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Negative.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5],
				:trainings  => row[6]
			}
		)

	end
	puts('done migrating TRAIN negative images')
end



csv_file_path = "#{Rails.root}/db/seed_data/eval_positives.csv"

#puts(csv_file_path)

if Evalpositive.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Evalpositive.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5],
				:positives => row[6]					
			}
		)

	end
	puts('done migrating EVAL positive images')
end

csv_file_path = "#{Rails.root}/db/seed_data/eval_negatives.csv"

if Evalnegative.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Evalnegative.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5],
				:detections => row[6],
				:positives  => row[7]
			}
		)

	end
	puts('done migrating EVAL negative images')
end