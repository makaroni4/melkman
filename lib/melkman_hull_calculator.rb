require 'fileutils'
require_relative 'animator'
require_relative 'graph'
require_relative 'simple_chain_generator'

class MelkmanHullCalculator
  def initialize(snapshooter = nil)
    @snapshooter = snapshooter
  end

  def calculate(points)
    deque = []

    if is_left(points[0], points[1], points[2]) > 0
      deque.push(points[0])
      deque.push(points[1])
    else
      deque.push(points[1])
      deque.push(points[0])
    end
    deque.push(points[2])
    deque.insert(0, points[2])

    @snapshooter.snapshot!(points, deque, "00") if @snapshooter

    points[3..-1].each_with_index do |point, i|
      next if is_left(point, deque[0], deque[1]) > 0.0 && is_left(deque[-2], deque[-1], point) > 0.0

      @snapshooter.snapshot!(points, deque, "#{i + 3}0") if @snapshooter

      while is_left(deque[-2], deque[-1], point) <= 0.0 do
        deque.pop
      end
      deque.push(point)

      @snapshooter.snapshot!(points, deque, "#{i + 3}1") if @snapshooter

      while is_left(deque[0], deque[1], point) <= 0.0 do
        deque.shift
      end
      deque.insert(0, point)

      @snapshooter.snapshot!(points, deque, "#{i + 3}2") if @snapshooter
    end

    deque
  end

  private
  def is_left(p0, p1, p2)
    ((p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y - p0.y))
  end
end
