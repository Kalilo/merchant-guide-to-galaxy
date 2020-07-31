# frozen_string_literal: true

$LOAD_PATH.unshift File.join(__dir__, 'tests')
$LOAD_PATH.unshift File.join(__dir__, 'srcs')

Dir[File.join(__dir__, 'tests', '*.rb')].sort.each { |file| require file }
