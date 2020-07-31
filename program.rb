# frozen_string_literal: true

$LOAD_PATH.unshift File.join(__dir__, 'srcs')

require 'evaluator'
require 'pry'

filename = ARGV[0]
evaluator = Evaluator.new

filename.nil? ? evaluator.repl : evaluator.run_file(filename)
