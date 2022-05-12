=begin 
  * messy solution, definitely needs refactoring and handling edge case
  * last updated 12.5.22

=end



require 'pry'

class Banner

  def initialize(message, width = message.length)
    @message = message
    @width = width
  end

  def to_s
    if @width == @message.length
      [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
    else 
      [horizontal_rule, empty_line, wrap_text, empty_line, horizontal_rule].join("\n")
    end
  end

  def wrap_text
    # To boldly go where no one has gone before. 
    # ["To", "boldly", "go", "where", "no", "one", "has", "gone", "before."]
    # word = "To", substr = ""
    # wor
    wrapped_text = []
    words = message.split # split the message by whitespaces and iterate through each word
    wrapped_text << words.shift + ' '
    words.each do |word| # iterate through each word of this array
      if (wrapped_text.last.length + word.length < width) # if this word can fit, (if the length of word + substring + ' ' is less than desired width)
        wrapped_text.last << (word + ' ') # add the word to the substring
      else # if it can't
        if word.length > width # if the current word can't even fit in the width
          loop do # keep wrapping until it can
            # substr = word[0, width] # get the substring of this word (length = width)
            # word = word[width, word.length]
            # wrapped_text << substr # add substr to wrapped text
            # if word.length < width # loop this until left with a substring with length less than width
            #   substr = word # set substring equal to remaining
            #   break
            # end
            puts "word can't fit!"
            wrapped_text << (word + ' ') # append new element to array
            break
          end
        else
          wrapped_text.last.strip! # add substring to wrapped text
          wrapped_text << (word + ' ') # append new element to array
        end
      end
    # continue until end of string is reached
    # add the remaining bit of substring to the wrapped_text array
    # return the a string of the array joined by newline
    end
    # wrapped_text << substr
    wrapped_text.map! do |line|
      line.strip.center(width + 2).center(width + 4, '|')
    end.join("\n")
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

banner = Banner.new('To boldly go where no one has gone before.', 30)
# puts banner
puts banner
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