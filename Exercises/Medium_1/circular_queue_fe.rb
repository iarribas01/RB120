class CircularQueue
  def initialize(buffer_size)
    @array = []
    @buffer_size = buffer_size
  end

  def enqueue(element)
    if array.length < buffer_size
      array.push(element) 
    else
      array.shift
      array.push(element)
    end
  end

  def dequeue
    return nil if array.empty?
    array.shift
  end

  private

  attr_reader :array, :buffer_size
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil


queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)

puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil