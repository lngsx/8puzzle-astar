class Puzzle
	attr_accessor :root, :order, :g, :h, :f
	@@num_for_each_row = 3
	@@goal = [1,2,3,8,0,4,7,6,5]
	@@cost_factor = 0.265

	def initialize(options)

#		@g = options[:g] || 0
#		@root = options[:root] || 0
#		if @root.is_a? Puzzle
#			@g = @@cost_factor + @root.g
#		end#

#		@order = options[:order]
#		
#		@h = cal_h

#		@f = @g + @h#

#	
	@g = 0
	@f = 0
	@root = options[:root] || 0
	@order = options[:order]

	end

	def show
		count = 0
		puts "----------------"
		@order.each do |tile|
			
			if count == 3 
				puts ""
				count = 0
			end
			count +=1
			print "#{tile} "
		end
		puts "\ng = #{@g}.   h = #{@h}.   f = #{@f}\n"
	end

	def override_goal (arr)
		@@goal = arr
	end

	def get_goal
		@@goal
	end

	def cal_h
		find_misplaced


	end

	def cal_g

	end

	def cal_f

	end

	def find_next_move

		position = find_0
		row = get_row (position)
		col = get_col (position)
		
		next_moves = []
		max_axis = @@num_for_each_row-1


		if @root.is_a? Puzzle
			#puts "I HAVE PARENT"

			up = move_up position
			down = move_down position
			left = move_left position
			right = move_right position

			next_moves.push Puzzle.new(:order => up) if row > 0 && up != @root.order
			
			next_moves.push Puzzle.new(:order => down) if row < max_axis && down != @root.order
			
			next_moves.push Puzzle.new(:order => left) if col > 0 && left != @root.order
			
			next_moves.push Puzzle.new(:order => right) if col < max_axis && right != @root.order
			
					
		else
			next_moves.push Puzzle.new(:order => move_up(position)) if row > 0 
			next_moves.push Puzzle.new(:order => move_down(position)) if row < max_axis 
			next_moves.push Puzzle.new(:order => move_left(position)) if col > 0 
			next_moves.push Puzzle.new(:order => move_right(position)) if col < max_axis
		end

		

		next_moves

	end

	private
	#------------------------- private ---------------------------

	def find_misplaced
		misplaced = 0
		@order.size.times do |i|
			misplaced +=1 if @order[i] != @@goal[i]
		end
		misplaced*=@@cost_factor
		
	end

	def find_manhattan


		@order.each do |tile|
			
		end



		@position = find_0
		row = get_row
		col = get_col
		next_moves = []
		max_axis = @@num_for_each_row-1

		if @root.is_a? Puzzle
			next_moves.push Puzzle.new(:order => move_up) if row > 0 && move_up != @root.order
			next_moves.push Puzzle.new(:order => move_down) if row < max_axis && move_down != @root.order
			next_moves.push Puzzle.new(:order => move_left) if col > 0 && move_left != @root.order
			next_moves.push Puzzle.new(:order => move_right) if col < max_axis && move_right != @root.order			
		else
			next_moves.push Puzzle.new(:order => move_up) if row > 0 
			next_moves.push Puzzle.new(:order => move_down) if row < max_axis 
			next_moves.push Puzzle.new(:order => move_left) if col > 0 
			next_moves.push Puzzle.new(:order => move_right) if col < max_axis
		end
		next_moves		
	end

	def find_0
		@order.index(0) 
	end

	def get_row (pos)
		pos/@@num_for_each_row
	end

	def get_col (pos)
		pos % @@num_for_each_row
	end


	def move_up (pos)
		#puts "up!"
		array = @order.clone
		array[pos], array[pos-@@num_for_each_row] = array[pos-@@num_for_each_row],array[pos]
		array
	end

	def move_down (pos)
		#puts "down!"
		array = @order.clone
		array[pos], array[pos+@@num_for_each_row] = array[pos+@@num_for_each_row],array[pos]
		array
	end

	def move_left (pos)
		#puts "left!"
		array = @order.clone
		array[pos], array[pos-1] = array[pos-1],array[pos]
		array
	end

	def move_right (pos)
		#puts "right!"
		array = @order.clone
		array[pos], array[pos+1] = array[pos+1],array[pos]
		array
	end

end





