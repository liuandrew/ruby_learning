

module Enumerable
    def my_each
        for i in self
            yield i
        end
    end
    
    def my_each_with_index
        for i in 0..self.length-1
            yield self[i], i
        end
    end
    
    def my_select
        selectArray = []
        self.my_each do |i|
            selectArray.push(i) if yield i
        end
        return selectArray
    end
    
    def my_all?
        self.my_each do |i|
            return false unless yield i
        end
        return true
    end
    
    def my_any?
        self.my_each do |i|
            return true if yield i
        end
        return false
    end
    
    def my_none?
        self.my_each do |i|
            return false if yield i
        end
        return true
    end
    
#    def my_count(value)
#        count = 0
#        self.my_each {|i| count += 1 if i == value}
#        return count
#    end
#    
#    def my_count
#        self.length
#    end
#    
    def my_count(&block)
        count = 0
        self.my_each {|i| count += 1 if yield i}
        count
    end
    
    def my_map 
        self.my_each_with_index do |value, i|
            self[i] = (yield value)
        end
        return self
    end
    
    def my_inject
        total = self[0]
        self.my_each do |i|
            next if i == self[0]
            total = yield total, i
        end
        return total
    end
end

def multiply_els(array)
    array.my_inject {|t, i| t * i}
end
