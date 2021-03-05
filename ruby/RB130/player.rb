require "byebug"

def mutate_me(collection, &block)
  return collection if !block_given?

  collection.each_with_index do |e, i|
    collection[i] = block.call(e)
  end
end


p mutate_me([[1,2], "a"]) do |el|
  el.is_a?(Array) ? el.reverse : el
end # [[2, 1], [3, 2], [4, 3], "a", "b", "c"]

