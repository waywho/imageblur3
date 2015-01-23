class ImageBlur
	attr_reader :width, :height

	def initialize(image)
		@image = image
		@width = @image[1].length - 1
		@height = @image.length - 1
	end

	def output_image
		@image.each do |row|
			print row.join("")
			puts
		end
	end

	def locate_pixl
		@locus = []
		@image.each_index do |row_index|
			sub_image = @image[row_index]
			sub_image.each_index do |pixl_index|
				if sub_image[pixl_index] == 1
					@locus << [row_index, pixl_index]
				end
			end
		end
		return @locus
	end

	def blur(distance)
		self.locate_pixl
		@locus.each do |row, pixl|

			x = distance
			d = 0
			until x < 0 do
				can_move_left = pixl != 0 && pixl - x >= 0
				can_move_right = pixl != @width && pixl + x <= width
				can_move_up = row != 0 && row - x >= 0
				can_move_down = row != @height && row + x <= height

				can_move_left ? d_left = pixl - x : d_left = 0
				can_move_right ? d_right = x + pixl : d_right = width
				can_move_up ? d_up = row - d : d_up = 0
				can_move_down ? d_down = row + d : d_down = height


				blur_arry = Array.new((d_right - d_left) + 1, 1)

				@image[d_up][d_left..d_right] = blur_arry 
				@image[d_down][d_left..d_right] = blur_arry 

				x -= 1
				d += 1
			end
		end
	end
end

image = ImageBlur.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])
image.blur(1)
image.output_image
puts

image = ImageBlur.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])
image.blur(2)
image.output_image
puts

image = ImageBlur.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1]
])
image.blur(3)
image.output_image
puts


image = ImageBlur.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1]
])
image.blur(4)
image.output_image
puts
