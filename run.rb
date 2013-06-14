require_relative 'melkman_hull_calculator'

chain_drawer = SimpleChainGenerator.new(scatter: 200)
points = chain_drawer.draw_simple_polygonal_chain(15, 270)

calculator = MelkmanHullCalculator.new
calculator.calculate(points)

animator = Animator.new
animator.animate(Dir["#{Dir.pwd}/#{SNAPSHOTS_DIR}/*.jpg"])
