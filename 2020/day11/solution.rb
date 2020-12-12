#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   L.LL.LL.LL
  #   LLLLLLL.LL
  #   L.L.L..L..
  #   LLLL.LL.LL
  #   L.LL.LL.LL
  #   L.LLLLL.LL
  #   ..L.L.....
  #   LLLLLLLLLL
  #   L.LLLLLL.L
  #   L.LLLLL.LL
  # DATA
end

class Room
  def initialize(rows)
    @seats = []
    rows.each_with_index do |row, x|
      @seats.push([])
      row.chars.each_with_index do |icon, y|
        @seats[x].push(Seat.new(self, x, y, icon))
      end
    end
  end

  def seats
    @seats.flatten
  end

  def seat_at(x, y)
    return unless [x, y].all? { |e| e >= 0 }

    @seats[x][y] if @seats[x]
  end

  def next_generation!
    affected = []
    seats.each do |seat|
      affected.push seat if seat.vacant? && seat.occupied_neighbours.none?
      affected.push seat if seat.occupied? && seat.occupied_neighbours.compact.length >= 4
    end
    return false if affected.empty?

    affected.each(&:toggle!)
    true
  end

  def occupied_seat_count
    seats.count(&:occupied?)
  end
end

class Seat
  attr_reader :room, :x, :y

  def initialize(room, x, y, icon)
    @room = room
    @x = x
    @y = y
    @occupied = false
    @absent = true if icon == "."
  end

  def vacant?
    !@absent && !@occupied
  end

  def occupied?
    @occupied
  end

  def toggle!
    (@occupied = !@occupied) unless @absent
  end

  def neighbours
    @neighbours ||= gather_neighbours
  end

  def gather_neighbours
    neighbours = []
    neighbours.push(@room.seat_at(x - 1, y - 1))
    neighbours.push(@room.seat_at(x - 1, y))
    neighbours.push(@room.seat_at(x - 1, y + 1))

    neighbours.push(@room.seat_at(x, y - 1))
    neighbours.push(@room.seat_at(x, y + 1))

    neighbours.push(@room.seat_at(x + 1, y - 1))
    neighbours.push(@room.seat_at(x + 1, y))
    neighbours.push(@room.seat_at(x + 1, y + 1))

    neighbours.compact
  end

  def occupied_neighbours
    neighbours.select(&:occupied?)
  end
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
ROWS = DATA.split

def part1
  room = Room.new(ROWS)
  loop while room.next_generation!
  room.occupied_seat_count
end

def part2
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
