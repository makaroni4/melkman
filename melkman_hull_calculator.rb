require 'fileutils'
require './animator'
require './graph'
require './simple_chain_generator'

SNAPSHOTS_DIR = 'snapshots'

class MelkmanHullCalculator
  def calculate(points)
    FileUtils.rm_rf(SNAPSHOTS_DIR)
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

    snapshot(points, deque, "00")

    points[3..-1].each_with_index do |point, i|
      next if is_left(point, deque[0], deque[1]) > 0.0 && is_left(deque[-2], deque[-1], point) > 0.0

      snapshot(points, deque, "#{i + 3}0")
      while is_left(deque[-2], deque[-1], point) <= 0.0 do
        deque.pop
      end
      deque.push(point)

      snapshot(points, deque, "#{i + 3}1")

      while is_left(deque[0], deque[1], point) <= 0.0 do
        deque.shift
      end
      deque.insert(0, point)

      snapshot(points, deque, "#{i + 3}2")
    end

    deque
  end

  private
  def is_left(p0, p1, p2)
    ((p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y - p0.y))
  end

  def snapshot(points, deque, pointer)
    create_snapshots_dir
    drawer = HullDrawer.new(
      points: points,
      hull_points: deque.compact,
      img_name: "#{SNAPSHOTS_DIR}/#{pointer}.jpg"
    )
    drawer.draw
  end

  def create_snapshots_dir
    Dir.mkdir(SNAPSHOTS_DIR) unless Dir.exists?(SNAPSHOTS_DIR)
  end
end
