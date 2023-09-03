require "byebug"

class Board
    attr_reader :size

    def self.print_grid(grid)
        grid.each do |row|
            puts row.join(" ")
        end
    end

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](indices)
        row, col = indices
        @grid[row][col]
    end

    def []=(position, value)
        row, col = position
        @grid[row][col] = value
    end

    def num_ships
        @grid.flatten.count { |ele| ele == :S }
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts 'you sunk my battleship!'
            return true
        else
            self[position] = :X
            false
        end
    end

    def place_random_ships
        ships = @size / 4 

        while num_ships < ships
            row = rand(0...@grid.length)
            col = rand(0...@grid.length)
            @grid[row][col] = :S
        end
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map { |col| col != :S ? col : col = :N }
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end