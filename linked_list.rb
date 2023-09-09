class LinkedList
  # attr_reader :head, :tail
  
  def initialize
    @head = nil
    @number_of_nodes = 0
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    # if this is the first node, it should be the head and the tail
    if @number_of_nodes == 0
      @head = node
    # if there is only one node
    elsif @number_of_nodes == 1
      @head.next_node(node)
    else
      @tail.next_node(node)
    end
    @tail = node
    @number_of_nodes += 1
  end

  def prepend(value)
    node = Node.new(value)
    if @number_of_nodes == 0
      @tail = node
    elsif @number_of_nodes == 1
      node.next_node(@tail)
    else
      node.next_node(@head)
    end
    @head = node
    @number_of_nodes += 1
  end

  def size
    @number_of_nodes
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def at(index)
    node = @head
    for i in 0..index - 1
      node = node.pointer
    end
    unless node
      return "does not exist"
    end
    node
  end

  def pop
    # find the node before the tail and set it to tail and its pointer to nil
    node = @head
    @number_of_nodes.times do
      if node.pointer == @tail
        @tail = node
        @tail.pointer = nil
        break
      end
      node = node.pointer
    end
    @number_of_nodes -= 1
  end

  def contains?(value)
    node = @head
    @number_of_nodes.times do
      if node.value == value
        return true
      end
      node = node.pointer
    end
    return false
  end

  def find(value)
    node = @head
    for i in 0..@number_of_nodes - 1
      if node.value == value
        return i
      end
      node = node.pointer
    end
    return nil
  end

  def to_s
    arr = []
    node = @head
    @number_of_nodes.times do
      arr << "( #{node.value} )"
      if node.pointer == nil
        arr << " -> nil"
      else
        arr << " -> "
      end
      node = node.pointer
    end
    arr.join
  end

  def insert_at(value, index)
    return if index > @number_of_nodes
    if index == 0
      self.prepend(value)
    elsif index == @number_of_nodes
      self.append(value)
    else
      node_before = self.at(index - 1)
      node_after = node_before.pointer
      node = Node.new(value)
      node_before.pointer = node
      node.next_node(node_after)
      @number_of_nodes += 1
    end
  end

  def remove_at(index)
    return if index > @number_of_nodes - 1
    if index == @number_of_nodes - 1
      self.pop
    elsif index == 0
      new_head = @head.pointer
      @head.pointer = nil
      @head = new_head
      @number_of_nodes -= 1
    else
      node_before = self.at(index - 1)
      node_removed = node_before.pointer
      node_after = node_removed.pointer
      node_removed.pointer = nil
      node_before.next_node(node_after)
      @number_of_nodes -= 1
    end
  end
end

class Node
  attr_reader :value
  attr_accessor :pointer

  def initialize(value = nil)
    @value = value
    @pointer = nil
  end

  def next_node(node)
    @pointer = node
  end

end

list = LinkedList.new
list.append(33)
list.prepend(22)
list.append(44)
list.prepend(11)
list.pop
list.insert_at(87, 3)
list.remove_at(3)

puts list
