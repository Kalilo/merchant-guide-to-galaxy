reqire 'evaluator'

filename = ARGV[0]

evaluator = Evaluator.new

filename.nil? ? evaluator.repl : run_file(filename)

