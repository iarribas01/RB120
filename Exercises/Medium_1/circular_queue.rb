class FixedArray
  def initialize(max_length)
    @array = Array.new(max_length)
  end

  def [](index)
    array.fetch(index)
  end

  def []=(index, element)
    self[index]
    @array[index] = element
  end

  def to_a
    array.clone
  end

  def to_s
    to_a.to_s
  end

  private

  attr_reader :array
end

class CircularQueue < FixedArray
  def initialize(buffer_size)
    super(buffer_size)
    @start_index = 0 # pos of first added element
    @end_index = 0 # pos of most recent added element
  end

  # add object to queue
  def enqueue(element)
    if array[end_index] != nil # when overwriting an element
      # shift the start index along with the end index
      shift_start_index
    end
    array[end_index] = element
    shift_end_index
  end

  # remove and return oldest object in queue
  # nil if queue is empty
  def dequeue
    return nil if empty?
    deleted_element = array[start_index]
    array[start_index] = nil
    shift_start_index
    deleted_element
  end

  private

  def length
    array.count{ |e| e != nil }
  end

  def empty?
    length == 0
  end

  def shift_start_index
    self.start_index = shift(start_index)
  end

  def shift_end_index
    self.end_index = shift(end_index)
  end

  def shift(index)
    if index >= array.length - 1
      index = 0
    else
      index + 1
    end
  end

  attr_accessor :start_index, :end_index
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