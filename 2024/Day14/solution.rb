#!/usr/bin/env ruby

class Solution
  LOBBY_WIDTH = 101
  LOBBY_HEIGHT = 103

  def input
    File.readlines(File.join(__dir__, "input.txt"))
  end

  def robot_attributes
    @robot_attributes ||=
      input.map { |line|
        line.scan(/-?\d+/).map(&:to_i)
      }
  end

  class Robot
    attr_accessor :x_pos, :y_pos

    def initialize(x_pos, y_pos, x_vel, y_vel)
      @x_pos = x_pos
      @y_pos = y_pos
      @x_vel = x_vel
      @y_vel = y_vel
    end

    def move(multiplier)
      @x_pos = (@x_pos + (@x_vel * multiplier)) % LOBBY_WIDTH
      @y_pos = (@y_pos + (@y_vel * multiplier)) % LOBBY_HEIGHT
    end
  end

  def robots
    @robots ||=
      robot_attributes.map { |attrs|
        Robot.new(*attrs)
      }
  end

  def danger_level
    top_left =
      robots.count { |robot|
        robot.x_pos < LOBBY_WIDTH / 2 && robot.y_pos < LOBBY_HEIGHT / 2
      }
    top_right =
      robots.count { |robot|
        robot.x_pos > LOBBY_WIDTH / 2 && robot.y_pos < LOBBY_HEIGHT / 2
      }
    bottom_left =
      robots.count { |robot|
        robot.x_pos < LOBBY_WIDTH / 2 && robot.y_pos > LOBBY_HEIGHT / 2
      }
    bottom_right =
      robots.count { |robot|
        robot.x_pos > LOBBY_WIDTH / 2 && robot.y_pos > LOBBY_HEIGHT / 2
      }
    [top_left, top_right, bottom_left, bottom_right].inject(1, :*)
  end

  def part1
    @robots = nil
    robots.each { |robot| robot.move(100) }
    danger_level
  end

  def part2
    @robots = nil
    min_danger_level = danger_level
    min_danger_level_step = 0
    (1..(LOBBY_WIDTH * LOBBY_HEIGHT)).each do |step|
      robots.each { |robot| robot.move(1) }
      current_danger_level = danger_level
      next if current_danger_level >= min_danger_level

      min_danger_level = current_danger_level
      min_danger_level_step = step
    end

    min_danger_level_step
  end

  def solutions
    p1 = part1
    puts "Part1: #{p1} #{p1 == 211_692_000 ? '✅' : '❌'}"
    p2 = part2
    puts "Part2: #{p2} #{p2 == 6587 ? '✅' : '❌'}"
  end
end

Solution.new.solutions
