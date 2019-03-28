require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if list.include?(key)
      list.update(key, val)
    else
      resize! if count == num_buckets
      list.append(key, val)
      @count += 1
    end 
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removed = bucket(key).remove(key)
    @count -= 1 if removed
    removed
  end

  def each
    @store.each do |bucket|
      bucket.each { |node| yield(node.key, node.val) } 
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_set = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_set.each do |bucket|
      bucket.each { |node| self.set(node.key, node.val) }
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
