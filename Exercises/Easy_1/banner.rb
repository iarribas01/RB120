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

    # To boldly go where no one has gone before. 
    substr = ""
    wrapped_text = []
    # split the message by whitespaces and iterate through each word
    words = message.split.each do |word| # iterate through each word of this array
      puts "#{word} : #{word.length}"
      # have a current substring
      if (substr.length + word.length < width) # if this word can fit, (if the length of word + substring + ' ' is less than desired width)
        substr << (word + ' ') # add the word to the substring
      else # if it can't
        if substr.empty?
        # yes
          loop do
            substr = word[0, width] # get the substring of this word (length = width)
            word = word[width, word.length]
            wrapped_text << substr # add substr to wrapped text
            if word.length < width # loop this until left with a substring with length less than width
              substr = word # set substring equal to remaining
              break
            end
          end
        else
        # no 
          wrapped_text << substr.strip # add substring to wrapped text
          substr = "" # reset substring to be empty
        end
      end
    # continue until end of string is reached
    # add the remaining bit of substring to the wrapped_text array
    # return the a string of the array joined by newline
    end
    p substr
    # wrapped_text << substr
    p wrapped_text
  end


  ##### note: debug --- need to check how to add in the last string after splitting 
  # the message into an array

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