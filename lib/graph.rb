require 'matrix'
# require_relative './vertex'

class Graph
	Vertex = Struct.new(:name, :nearby, :cost, :previous)

	def initialize graph
		@vertices = Hash.new { |i, j| i[j] = Vertex.new(j, [], Float::INFINITY) }
		@edges = {}

		graph.each do |v1, v2, cost|
			@vertices[v1].nearby << v2
			@vertices[v2].nearby << v1
			@edges[[v1, v2]] = @edges[[v2, v1]] = cost
		end
		@start_point = nil
	end

	def calc_min_path(start_point, goal)
		dijkstra(start_point)
		path = []
		g = goal
		while g
			path.unshift(g)
			g = @vertices[g].previous
		end
		return path, @vertices[goal].cost
	end

	# the algorithm of Dijkstra
	def dijkstra(start_point)
		# return if i am going to the same vertex, ex.: start = 1, goal = 1
		return if @start_point == start_point

		vertices_values = set_values_to_vertices

		@vertices[start_point].cost = 0

		until vertices_values.empty?
			vmin = vertices_values.min_by { |vertex| vertex.cost }
			break if vmin.cost == Float::INFINITY

			vertices_values.delete(vmin)
			vmin.nearby.each do |v|
				vv = @vertices[v]
				if vertices_values.include?(vv)
					aux = vmin.cost + @edges[[vmin.name, v]]
					if aux < vv.cost
						vv.cost = aux
						vv.previous = vmin.name
					end
				end
			end
		end
		@start_point = start_point
	end

	# just a method to setup the vertices
	# the distance of initial node is 0
	# and it is infinite for the other nodes
	def set_values_to_vertices
		list = @vertices.values
		list.each do |vv|
			vv.cost = Float::INFINITY
			vv.previous = nil
		end
		list
	end

end
