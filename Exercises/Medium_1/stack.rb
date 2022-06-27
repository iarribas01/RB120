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
    execute_commands
  end

  def execute_commands
    commands.each do |command|
      if int? command
        n(command.to_i)
      else
        send(command)
      end
    end
  end
  
  # loads num onto register
  def n(num)
    self.register = num
  end
  
  # prints number on register
  def print
    puts register
  end

  # pushes current register to
  def push
    stack << register
  end

  def add
    self.register = stack.pop + register
  end

  def multiply
    self.register = stack.pop * register
  end

  # remove topmost on stack and place in register
  def pop
    if stack.empty?
      puts "Empty stack!"
    end
    self.register = stack.pop
  end

  def divide
    self.register = register / stack.pop
  end

  def modulo
    self.register = register % stack.pop
  end

  def subtract
    self.register = register - stack.pop
  end

  # interprets the string of input
  # and splits into different symbols with args
  def interpret
    input.split.each do |i|
      commands << interpret_command(i)
    end
  end

  # interprets a single string command and returns a symbol
  # of the method name
  # InvalidTokenError raised if string isn't recognized in lang
  def interpret_command(command)
    return command if int?(command)
    case command
    when 'PRINT' then :print
    when 'PUSH'  then :push
    when 'ADD'   then :add
    when 'SUB'   then :subtract
    when 'MULT'  then :multiply
    when 'DIV'   then :divide
    when 'MOD'   then :modulo
    when 'POP'   then :pop
    else               raise InvalidTokenError, "Invalid Token #{command}"
    end
  end

  def int?(str)
    !!(str =~ /\A[-+]?\d+\z/)
  end

  private

  attr_reader :input, :stack
  attr_accessor :commands, :register
end


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

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)