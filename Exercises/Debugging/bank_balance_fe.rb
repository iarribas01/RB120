class Bank
  attr_reader :balance
  
  def initialize
    @balance = 0
  end

  def balance=(new_balance)
    new_balance += 5
    @balance = new_balance
  end
end

account = Bank.new
p (account.balance = 10)
puts account.balance