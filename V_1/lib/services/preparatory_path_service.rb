class PreparatoryPathService
	def initialize(customers, distance_matrix)
		ids_from = []
		way =[]
		ids_end = []
		common_delay_time = 0
		list_sort_by_from = customers.sort_by{|customer| customer.time1}
		list_sort_by_end = customers.sort_by{|customer| customer.time2}	
		ids_from = list_sort_by_from.map(&:id)
		ids_end = list_sort_by_end.map(&:id)
		path = check_path(ids_from, ids_end)
		longest_sequence = find_longest_sequence(path)
		current_time = 0
		longest_sequence.each_with_index do |vertex, index|
			if index != longest_sequence.length - 1
				customers.each do |customer|
					if vertex == customer.id
						debugger if vertex == 2
						if current_time == 0 
							current_time = customer.time1 + customer.service_time
						else
							current_time = current_time +customer.service_time
						end
						next_vertex = distance_matrix[vertex-1][longest_sequence[index+1]-1]
						if !next_vertex.nil?
							on_way = next_vertex[:distance] 
							until_next_vertex = current_time + on_way
							if next_vertex[:to] > until_next_vertex
								delay_time = next_vertex[:from] - until_next_vertex
								way << vertex - 1
								if delay_time < 0 
									current_time = until_next_vertex
								else
									current_time = next_vertex[:from]
									common_delay_time += delay_time
								end
							else 
								way << vertex - 1 
								puts("Not possible")
								puts(common_delay_time)
								puts(way.to_s)
							end
							common_delay_time
						end
					end
					current_time
				end
			end
		end
	end

	def check_path(from_path, end_path)
		result = {}
		size = from_path.length
		from_path.each_with_index do |vertex_from, index_from|
			offset = end_path.index(vertex_from) - index_from
			j=index_from
			result[from_path[index_from]] = []
			while j < size do
				if from_path[j] == end_path[j+offset]
					result[from_path[index_from]] << end_path[j+offset]
				end
				j +=1
			end
		end
		result
	end

	def find_longest_sequence(path)
		long = 0
		longest_way = {}
		path.each do |el|
			if long < el[1].length
				long = el[1].length 
				longest_way = el[1]
			end
		end
		longest_way
	end

end