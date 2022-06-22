=begin

problem: NameError, uninitialized constant File::FORMAT
  constants have a lexical scope and will only
  try to resolve a constant travelling up an inheritance
  tree, not down

solution 1:
  - rewrite the to_s method in File and copy and past
    the to_s method in all subclasses to use FORMAT of
    respective class

      super + FORMAT.to_s

    - access first by current class instance and
    then by respective constant. self.class.CONSTANT



=end

class File
  attr_accessor :name, :byte_content, :format

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post