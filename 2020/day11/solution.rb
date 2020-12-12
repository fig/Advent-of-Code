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
    return if [x, y].any?(&:negative?)

    @seats[x][y] if @seats[x]
  end

  def next_generation!
    affected = []
    seats.each do |seat|
      affected << seat if seat.vacant? && seat.occupied_neighbours.none?
      affected << seat if seat.occupied? && 3 < seat.occupied_neighbours.compact.length
    end
    return false if affected.empty?

    affected.each(&:toggle!)
    true
  end

  def next_next_generation!
    affected = []
    seats.each do |seat|
      affected << seat if seat.vacant? && seats_visible_from(seat).count(&:occupied?).zero?
      affected << seat if seat.occupied? && 4 < seats_visible_from(seat).count(&:occupied?)
    end
    return false if affected.empty?

    affected.each(&:toggle!)
    true
  end

  def occupied_seat_count
    seats.count(&:occupied?)
  end

  def seats_visible_from(seat)
    @current_seat = seat
    [
      seat_above,
      seat_above_right,
      seat_right,
      seat_bellow_right,
      seat_bellow,
      seat_bellow_left,
      seat_left,
      seat_above_left,
    ].compact
  end

  def seat_above(current = @current_seat)
    candidate = seat_at current.x - 1, current.y
    candidate&.absent? ? seat_above(candidate) : candidate
  end

  def seat_above_right(current = @current_seat)
    candidate = seat_at (current.x - 1), (current.y + 1)
    candidate&.absent? ? seat_above_right(candidate) : candidate
  end

  def seat_right(current = @current_seat)
    candidate = seat_at current.x, (current.y + 1)
    candidate&.absent? ? seat_right(candidate) : candidate
  end

  def seat_bellow_right(current = @current_seat)
    candidate = seat_at current.x + 1, (current.y + 1)
    candidate&.absent? ? seat_bellow_right(candidate) : candidate
  end

  def seat_bellow(current = @current_seat)
    candidate = seat_at current.x + 1, current.y
    candidate&.absent? ? seat_bellow(candidate) : candidate
  end

  def seat_bellow_left(current = @current_seat)
    candidate = seat_at (current.x + 1), (current.y - 1)
    candidate&.absent? ? seat_bellow_left(candidate) : candidate
  end

  def seat_left(current = @current_seat)
    candidate = seat_at current.x, (current.y - 1)
    candidate&.absent? ? seat_left(candidate) : candidate
  end

  def seat_above_left(current = @current_seat)
    candidate = seat_at (current.x - 1), (current.y - 1)
    candidate&.absent? ? seat_above_left(candidate) : candidate
  end
end

class Seat
  attr_reader :room, :x, :y, :absent

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

  def absent?
    @absent
  end

  def toggle!
    (@occupied = !@occupied) unless @absent
  end

  def neighbours
    @neighbours ||= gather_neighbours
  end

  def visible_others
    @visible_others ||= gather_visible
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

  def gather_visible
    visible = []
    visible.push(@room.seats_visible_from(self))
  end

  def occupied_neighbours
    neighbours.select(&:occupied?)
  end
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
ROWS = DATA.split

def part1(room = Room.new(ROWS))
  loop while room.next_generation!
  room.occupied_seat_count
end

def part2(room = Room.new(ROWS))
  loop while room.next_next_generation!
  room.occupied_seat_count
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
