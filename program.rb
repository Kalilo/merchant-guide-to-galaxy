# frozen_string_literal: true

$LOAD_PATH.unshift File.join(__dir__, 'srcs')

require 'evaluator'
require 'pry'

if ARGV.empty?
  Evaluator.new.repl
else
  ARGV.each { |filename| Evaluator.new.run_file(filename) }
end
