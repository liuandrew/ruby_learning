class Node
    def initialize(value = nil, children = Hash.new, parent = nil)
        @value = value
        @children = children
        @parent = parent
    end
    
    def value
        @value
    end
    
    def get_parent
        @parent
    end
    
    def get_children
        @children
    end
    
    def left
        @children[:left]
    end
    
    def right
        @children[:right]
    end
    
    def set_parent(node)
        @parent = node
    end
    
    def set_child(direction, node)
        if direction == 'right'
            @children[:right] = node
        elsif direction == 'left'
            @children[:left] = node
        else
            @children[direction] = node
        end
    end
    
    def has_children?
        return !@children.empty?
    end
    
    def display
        puts "I have a parent #{@parent.value}" if @parent != nil
        if self.has_children?
            @children.each do |position, node| 
                puts "I have a child, positioned #{position}#{", with a value of #{node.value}" if node.value != nil}"
            end
        else
            puts "I have no children"
        end
    end
end

class Tree
    def initialize(array, parent = nil)
        @nodes = []
        @parent = parent
    end
    
    def parent
        @parent
    end
    
    def nodes
        @nodes
    end
    
    def set_parent(array)
        parent = array.sort[array.length/2]
        
        @parent = Node.new(parent)
        @nodes << @parent
        parent
    end
    
    def bfs_shortest(starting_node, target_space, queue = [], visited = [starting_node])
        #queue holds queue[0]: values to search, queue[1]: values they came from (parent)
        paths = []
        queue = populate_queue(starting_node, visited)
        
        while !queue.empty?
            child = queue.shift
            until visited.last == child[1]
                visited.pop
            end
            visited << child[0]
            
            if child[0] == target_space || child[0].value == target_space
                storage = []
                visited.each do |node|
                    storage << node.value
                end
                paths << storage
                
                queue.each_with_index do |to_visit, index|
                    if to_visit[1] == child
                        queue.delete_at(index)
                    end
                end
                
            else
                add_to_queue = populate_queue(child[0], visited)
                
                if add_to_queue.empty?
                    visited.pop
                else
                    queue = add_to_queue + queue
                end
            end
        end
        puts_shortest_path(paths, visited.first, target_space)
    end
    
    def breadth_first_search(value, node = @parent, queue = [], visited = [node])
        if node == value || node.value == value
            return node
        elsif node.has_children?
            node.get_children.each do |direction, child|
                if visited.none?{|n| n == child}
                    visited.push(child)
                    queue.push(child)
                end
            end
            breadth_first_search(value, queue.shift, queue, visited, path)
        elsif !queue.empty?
            breadth_first_search(value, queue.shift, queue, visited, path)
        else
            puts "Value not found"
            return nil
        end
    end
    
    def depth_first_search(value, node = @parent, stack = [node], visited = [])
        visited << (node)
        if node == value || node.value == value
            return node
        elsif node.has_children?
            visit = nil
            node.get_children.each do |direction, child|
                if visited.none?{|n| n == child}
                    visit = child
                end
            end
            if visit == nil
                stack.pop
                depth_first_search(value, stack.last, stack, visited)
            else
                stack.push(visit)
                depth_first_search(value, visit, stack, visited)
            end
        elsif !stack.empty?
            stack.pop
            depth_first_search(value, stack.last, stack, visited)
        else
            puts "Value not found"
            return nil
        end
    end

    private

    def puts_shortest_path(paths, start, finish)
        index = nil
        paths.each_with_index do |path, i|
            if index == nil || paths[i].length < paths[index].length
                index = i 
            end
        end
        if start.class == "Node"
            start_value = start.value
        else 
            start_value = start
        end
        if finish.class == "Node"
            finish_value = finish.value
        else
            finish_value = finish
        end
        puts "The shortest path for you to go from #{start_value} to #{finish_value} is: "
        final_path = paths[index]
        final_path.each do |space|
            if space == final_path.first
                puts "Start at #{space}" 
            elsif space == final_path.last
                puts "and finally arrive at #{space}"
            else
                puts "then go to #{space}"
            end
        end
        puts "for a final path length of #{final_path.length} steps"
    end
    
    def populate_queue(node, visited)
        queue = []
        if node.has_children?
            node.get_children.each do |direction, child|
                if visited.none?{|n| n == child}
                    queue << [child, node]
                end
            end
        end
        return queue
    end
end

class BinaryTree < Tree
    def initialize(array, parent = nil)
        super
        build_binary_tree(array)
    end
    
    def bfs_shortest(target)
        super(@parent, target)
    end
    
    private
    
    def build_binary_tree(array)
        array.delete(set_parent(array))
        array.shuffle!
        array.each do |value|
            node = Node.new(value)
            place = find_binary_place(node, @parent)
            
            place[0].set_child(place[1], node)
            node.set_parent(place[0])
            
            @nodes << (node)
        end
    end
    
        def find_binary_place(node, parent)
        if node.value > parent.value
            if parent.right == nil
                return parent, 'right'
            else
                find_binary_place(node, parent.right)
            end
        elsif node.value <= parent.value
            if parent.left == nil
                return parent, 'left'
            else
                find_binary_place(node, parent.left)
            end
        end
    end
end

class KnightTree < Tree
    
    def initialize(board_size)
        @nodes = Hash.new
        @board_size = board_size
        build_move_nodes(board_size)
    end
    
    def display_space(space)
        @nodes[space].display
    end
    
    def space(node)
        @nodes[node]
    end
    
    def knight_moves(start, target_space)
        bfs_shortest(@nodes[start], @nodes[target_space])
    end
    
    private
    
    def build_move_nodes(board_size)
        board = []
        board_size.times do |row|
            board_size.times do |column|
                board << [row, column]
            end
        end
        board.each{|space| @nodes[space] = Node.new(space)}
        @nodes.each do |space, node| 
            moves = get_moves(space, board_size)
            moves.each do |move|
                node.set_child(move, @nodes[move])
            end
        end
    end
    
    def get_moves(space, board_size)
        moves = []
        if space[0] + 2 < board_size
            moves << [space[0]+2, space[1]+1] if space[1] + 1 < board_size
            moves << [space[0]+2, space[1]-1] if space[1] - 1 >= 0
        end
        if space[0] - 2 >= 0
            moves << [space[0]-2, space[1]+1] if space[1] + 1 < board_size
            moves << [space[0]-2, space[1]-1] if space[1] - 1 >= 0
        end
        if space[1] + 2 < board_size
            moves << [space[0]+1, space[1]+2] if space[0] + 1 < board_size
            moves << [space[0]-1, space[1]+2] if space[0] - 1 >= 0
        end
        if space[1] - 2 >= 0
            moves << [space[0]+1, space[1]-2] if space[0] + 1 < board_size
            moves << [space[0]-1, space[1]-2] if space[0] - 1 >= 0
        end
        moves
    end
    
end

#array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
#binary_tree = BinaryTree.new(array)
#binary_tree.bfs_shortest(23)

knight_tree = KnightTree.new(4)

knight_tree.knight_moves([0, 0], [3, 2])