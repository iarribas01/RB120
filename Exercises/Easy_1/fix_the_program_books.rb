=begin 
Covering questions:
  - Fix the program - Books (part 1)
  - Fix the program - Books (part 2)

=end


# class Book
#   attr_reader :title, :author
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

=begin 
Expected output:
  The author of "Snow Crash" is Neil Stephenson.
  book = "Snow Crash", by Neil Stephenson.
=end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

=begin 
What are the differences between attr_reader, attr_writer, 
and attr_accessor? Why did we use attr_reader instead of 
one of the other two? Would it be okay to use one of the 
others? Why or why not?

  reader - read only (getter method), writer - reassignment only (setter method)
  accessor - both setter and getter methods

  We used attr_reader because there is no point in the program
  where the ability to change the book object's title or author.
  It is okay to use the others as long as the program still runs
  without an error, but it is not best practice. Being restrictive
  of permissions prevents unwanted changes from happening or sensitive information
  being leaked.


  Adding the following code
    def title
      @title
    end

    def author
      @author
    end
  makes no change to the program whatsoever, but makes
  the code slightly less compact. The only advantage
  to this setup is allowing a programmer to easily
  customize the getters of the title and author
  variables
=end




############################


class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

=begin 
Expected output:
  The author of "Snow Crash" is Neil Stephenson.
  book = "Snow Crash", by Neil Stephenson.
=end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin 
What do you think of this way of creating and initializing 
  Book objects? (The two steps are separate.) Would it be 
  better to create and initialize at the same time like in
   the previous exercise? What potential problems, if any, 
   are introduced by separating the steps?


  The two ways of creating and initializing Book objects
  have their own advantages. The former (initializing
  the instance variables WITHIN the constructor) is good
  for making a robust program. This ensures that data 
  will not be forgotten by the programmer. The latter
  forces the programmer to memorize what variables need
  to be initialized.


=end