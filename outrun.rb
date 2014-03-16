def load_graph(src_file)
  # Reads the source file line by line and returns
  # an array of arrays of integers. Example:
  # [
      # [45],
      # [34, 2],
      # [87, 45, 8]
      # ...
  # ]
  tree = []
  File.readlines(src_file).each do |line|
    unless line.start_with?("#")
      num_array = line.split(" ").map { |s| s.to_i }
      tree.push(num_array)
    end
  end
  tree
end


def find_most_popular_route(tree)
  # Loops through the tree and keeps the total sum of the most popular
  # route to reach each of the nodes on that row in memory. Returns the
  # total sum of the most popular route.
  previous_row = []
  tree.each do |row|
    current_row = []
    row.each_with_index do |node, index|
      #  case 1, first row, nothing to compare
      if previous_row == []
        current_row.push(node)
      # case 2, first node on that row, just get the right parent node
      elsif index == 0
        current_row.push(node + previous_row[0])
      # case 3, last node on that row, just get the left parent node
      elsif index == row.size - 1
        current_row.push(node + previous_row[-1])
      # general case, get the more popular one of the two parent nodes
      else
        parents = [previous_row[index - 1], previous_row[index]]
        current_row.push(node +  parents.max)
      end
    end
    previous_row = current_row
  end
  previous_row.max
end

ARGV.each do |a|
  my_graph = load_graph(a)
  pop_route_total = find_most_popular_route(my_graph)
  print "\n"
  print pop_route_total
end