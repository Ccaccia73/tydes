# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_file_path = "#{Rails.root}/db/seed_data/positives.csv"

#puts(csv_file_path)

if Positive.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Positive.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5],
				:trainings  => row[6],
				:detections => row[7],
				:positives  => row[8]
					
			}
		)

	end
	puts('done migrating positive images')
end

csv_file_path = "#{Rails.root}/db/seed_data/negatives.csv"

if Negative.count == 0

	CSV.foreach(csv_file_path, {:col_sep => " ", :row_sep => "\n"}) do |row|

		Negative.create!({
				:name  => row[0],
				:code  => row[1],
				:dir   => row[2],
				:image => row[3],
				:x 	   => row[4],
				:y 	   => row[5],
				:trainings  => row[6],
				:detections => row[7],
				:positives  => row[8]
					
			}
		)

	end
	puts('done migrating negative images')
end

