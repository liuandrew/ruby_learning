

def bubble_sort(array)
    (array.length-1).downto(0) do |i|
        
        0.upto(i) do |j|
            if array[j+1] != nil && array[j] > array[j+1]
                temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
            end
        end
    end
    return array
end

def bubble_sort_by(array, &block)
    (array.length-1).downto(0) do |i|
        
        0.upto(i) do |j|
            difference = yield array[j], array[i]
            if difference < 0
                temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
            end
        end
    end
    return array
end
puts bubble_sort([4,3,78,2,0,2])

puts bubble_sort_by(["hi", "hello", "hey"]) { |left, right| right.length - left.length}
