# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return nil if self.empty?
        self.max - self.min
    end

    def average
        return nil if self.empty?
        self.sum / self.length.to_f
    end

    def median
        return nil if self.empty?
        sorted = self.sort
        mid = self.length / 2
        if self.length.odd?
            return sorted[mid]
        end
        return (sorted[mid-1] + sorted[mid]) / 2.0
    end

    def counts
        count = Hash.new(0)
        self.each { |ele| count[ele] += 1 }
        count
    end

    def my_count(value)
        count = 0
        self.each { |ele| count += 1 if ele == value }
        count
    end

    def my_index(value)
        self.each_index { |i| return i if value == self[i] }
        nil
    end

    def my_uniq
        uniq = {}
        self.each { |ele| uniq[ele] = true }
        uniq.keys
    end

    def my_transpose
        length = self.length
        result = []

        (0...length).each do |row|
            new_row = []
            (0...length).each do |col|
                new_row << self[col][row]
            end
            result << new_row
        end

        result
    end
end