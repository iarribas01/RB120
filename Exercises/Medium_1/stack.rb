class InvalidTokenError < StandardError; end

class Minilang
  def initialize(input)
    @input = input
    @register = 0
    @stack = []
    @commands = []
  end

  def eval
    interpret
    p commands


  end

  def print
    puts register
  end

  # interprets the string of input
  # and splits into different symbols with args
  def interpret
    input.split.each do |i|
      commands << interpret_command(i)
    end
  end

  def interpret_command(command)
    return command.to_i if int?(command)
    case command
    when 'PRINT' then :print
    when 'PUSH' then :push
    when 'ADD'   then :add
    when 'SUB'   then :subtract
    when 'MULT'  then :multiply
    when 'DIV'   then :divide
    when 'MOD'   then :divide
    when 'POP'   then :pop
    else               raise InvalidTokenError, "Invalid Token #{command}"
    end
  end

  def int?(str)
    str.to_i.to_s == str
  end

  private

  attr_reader :register, :input
  attr_accessor :commands

end\




Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)