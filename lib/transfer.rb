class Transfer
  attr_accessor :sender, :receiver, :status, :amount 
  
  def initialize(sender, receiver, amount)
    @receiver = receiver
    @sender = sender 
    @amount = amount
    @status = "pending"
  end 
  
  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end
  
  def execute_transaction
    if @sender.balance > @amount && @status == "pending" && self.valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else
      @status = "rejected" 
      "Transaction #{@status}. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount) 
      @receiver.deposit(@amount * -1)
      @status = "reversed"
    end
  end

end
