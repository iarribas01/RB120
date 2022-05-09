##### STILL NEED TO COMPLETE
## FURTHER EXPLORATION

class Banner

  def initialize(message, width = message.length)
    @message = message
    @width = width
  end

  def to_s
    if @width == @message.length
      [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
    else 
      wrap_text
    end
  end


=begin 
create an empty array
initialize start index to 0

loop until start index is equal or past messsage length
	check if end INDEX is in middle of word
	if in middle
		generate substring up to whitespace
    if no witespace, just take the substring in the middle
	if not in middle
		generate the substring
		trim any whitespace
		add this new substring to the wrapped array
	end

	reassign start index to substring's length
end

=end
  def wrap_text
    # returns an array of strings less than or equal to width
    wrapped_text = []
    start_index = 0
    temp = message.dup
    loop do
      substr = temp[/.{1,10}\s/]
      puts substr
      wrapped_text << substr
      temp = temp[substr.length, 100]
      # puts temp
      break if temp == nil || temp.length <= 0
    end
  end


  private

  

  def horizontal_rule
    "+-#{'-'*width}-+"
  end

  def empty_line
    "| #{' '*width} |"
  end

  # needs to be edited based on message length
  def message_line
    "| #{message} |"
  end

  attr_reader :message, :width
end

banner = Banner.new('To boldly go where no one has gone before.', 10)
# puts banner
banner.wrap_text
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner = Banner.new('')
# puts banner
# +--+
# |  |
# |  |
# |  |
# +--+