require_relative './lib/melkman_hull_calculator'
require_relative './lib/snapshooter'

chain_drawer = SimpleChainGenerator.new(scatter: 200)
points = chain_drawer.draw_simple_polygonal_chain(15, 270)

snapshooter = Snapshooter.new
calculator = MelkmanHullCalculator.new(snapshooter)
calculator.calculate(points)

animator = Animator.new
animator.animate(Dir["#{Dir.pwd}/#{Snapshooter::SNAPSHOTS_DIR}/*.jpg"])
