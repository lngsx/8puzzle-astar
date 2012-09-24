require "./puzzle.rb"
require 'rubygems'
require 'json'

# initialize the open list
open = []

# initialize the closed list
closed = []

initial_array = [8,3,5,4,1,6,2,7,0].shuffle
start_node = Puzzle.new(:order => initial_array)

# gold state is set to [1,2,3,8,0,4,7,6,5] by default.
# 1 2 3
# 8 0 4 
# 7 6 5
# if you want to change it, do it here by override_goal[ARRAY] method

puts "---------------------------------\n"

#put the starting node on the open list
open.push start_node

skip = false
found =false
final_state = nil


until found

	#find the node with the least f on the open list, call it "q"
	open.sort_by! {|node| node.f}
	q = open.shift

	#generate q's 8 successors
	next_moves = q.find_next_move


	#for each successor
	next_moves.each do |successor|
		#if successor is the goal, stop the search
		next if found

		#set its parent to q
		successor.root = q

		if successor.order != successor.get_goal


			#calculate cost
			successor.g = q.g + 0.265
			successor.h = successor.cal_h(:manhattan => true, :misplaced => true)
			successor.f = successor.g + successor.h

			#skip this successor if there is a better node in openlist or closedlist
#			open.each do |node|
#				@skip = true if node.order == successor.order && node.f <= successor.f
#			end
#
#			closed.each do |node|
#				@skip = true if node.order == successor.order && node.f <= successor.f
#			end
			
			#otherwise, add the node to the open list
			open.push successor #if @skip == false
			#@skip = false			
		else
			found = true 
			final_state = successor
		end	
	end


	#push q on the closed list
	closed.push q

end


#show  path
path = []
step =0;

#path.push final_state
curr = final_state
until curr.root == 0

		data = {"order" => curr.order}
		obj = {"id" => step, "data" =>data}
		
		path.push obj
		curr = curr.root
			
		step += 1
end

data = {"order" => curr.order}
obj = {"id" => step, "data" =>data}
path.push obj


header = { "node_visited" => closed.length}

output = {"header" => header, "content" => path}

output.each do |node|
	puts node
	#use .show to draw a puzzle
end
puts "#{closed.length} node visited"
puts "#{step+1} steps has moved"