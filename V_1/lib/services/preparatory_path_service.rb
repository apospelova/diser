class PreparatoryPathService
	def initialize(customers, distance_matrix)
		ids_from = []
		ids_end = []
		list_sort_by_from = customers.sort_by{|customer| customer.time1}
		list_sort_by_end = customers.sort_by{|customer| customer.time2}	
		ids_from = list_sort_by_from.map(&:id)	
		ids_end = list_sort_by_end.map(&:id)
		path = check_path(ids_from, ids_end)
		longest_sequence = find_longest_sequence(path)
		debugger
		

		
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