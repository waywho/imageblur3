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
		locus = []
		@image.each_index do |row_index|
			sub_image = @image[row_index]
			sub_image.each_index do |pixl_index|
				if sub_image[pixl_index] == 1
					locus << [row_index, pixl_index]
				end
			end
		end
		return locus
	end

	def blur_image
		pixl_locus = self.locate_pixl
		puts

		pixl_locus.each do |row, pixl|
			can_move_left = pixl != 0
			can_move_right = pixl != @width
			can_move_up = row != 0
			can_move_down = row != @height
			
			@image[row][pixl - 1] = 1 if can_move_left
			@image[row][pixl + 1] = 1 if can_move_right
			@image[row - 1][pixl] = 1 if can_move_up
			@image[row + 1][pixl] = 1 if can_move_down
		end
	end

	def blur(distance)
		pixl_locus = self.locate_pixl

		pixl_locus.each do |row, pixl|
			can_move_left_by = Proc.new {|n| pixl != 0 && pixl - n >= 0}
			can_move_right_by = Proc.new {|n| pixl != @width && pixl + n <= @width}
			can_move_up_by = Proc.new{|n| row != 0 && row - n >= 0}
			can_move_down_by = Proc.new {|n| row != @height && row + n <= @height}

			1.upto(distance) do |d|			
			@image[row][pixl - d] = 1 if can_move_left_by.call(d)
			@image[row][pixl + d] = 1 if can_move_right_by.call(d)
			@image[row - d][pixl] = 1 if can_move_up_by.call(d)
			@image[row + d][pixl] = 1 if can_move_down_by.call(d)

				1.upto(distance - d) do |x| 
					@image[row - d][pixl - x] = 1 if can_move_left_by.call(x) && can_move_up_by.call(d)
					@image[row + d][pixl - x] = 1 if can_move_left_by.call(x) && can_move_down_by.call(d)
					@image[row - d][pixl + x] = 1 if can_move_right_by.call(x) && can_move_up_by.call(d)
					@image[row + d][pixl + x] = 1 if can_move_right_by.call(x) && can_move_down_by.call(d)
				end
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

image.blur(4)
image.output_image