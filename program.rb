
$LOAD_PATH.unshift File.join(__dir__, 'srcs')

require 'evaluator'

filename = ARGV[0]
evaluator = Evaluator.new

filename.nil? ? evaluator.repl : run_file(filename)
