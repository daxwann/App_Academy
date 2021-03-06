# EASY

# Write a method that returns the range of its argument (an array of integers).
def range(arr)
  sorted = arr.sort
  return sorted.last - sorted.first
end

# Write a method that returns a boolean indicating whether an array is in sorted
# order. Use the equality operator (==), which returns a boolean indicating
# whether its operands are equal, e.g., 2 == 2 => true, ["cat", "dog"] ==
# ["dog", "cat"] => false
def in_order?(arr)
  return arr.sort == arr
end


# MEDIUM

# Write a method that returns the number of vowels in its argument
def num_vowels(str)
  vowels = "aAeEiIoOuU"
  count = 0
  str.each_char do |char|
    if vowels.include?(char)
      count += 1
    end
  end
  return count
end

# Write a method that returns its argument with all its vowels removed.
def devowel(str)
  vowels = "aAeEiIoOuU"
  newStr = ""
  str.each_char do |char|
    if !vowels.include?(char)
      newStr += char
    end
  end
  return newStr
end


# HARD

# Write a method that returns the returns an array of the digits of a
# non-negative integer in descending order and as strings, e.g.,
# descending_digits(4291) #=> ["9", "4", "2", "1"]
def descending_digits(int)
  newArr = []
  int.to_s.split('').sort.reverse.each { |char| newArr << char }
  return newArr
end

# Write a method that returns a boolean indicating whether a string has
# repeating letters. Capital letters count as repeats of lowercase ones, e.g.,
# repeating_letters?("Aa") => true
def repeating_letters?(str)
  prev = ''
  str.downcase.each_char do |char|
    if char == prev
      return true
    end
    prev = char
  end
  return false
end

# Write a method that converts an array of ten integers into a phone number in
# the format "(123) 456-7890".
def to_phone_number(arr)
  return "(" + arr[0..2].join + ") " + arr[3..5].join + "-" + arr[6..-1].join
end

# Write a method that returns the range of a string of comma-separated integers,
# e.g., str_range("4,1,8") #=> 7
def str_range(str)
  arr = str.split(",").sort
  return arr.last.to_i - arr.first.to_i
end


#EXPERT

# Write a method that is functionally equivalent to the rotate(offset) method of
# arrays. offset=1 ensures that the value of offset is 1 if no argument is
# provided. HINT: use the take(num) and drop(num) methods. You won't need much
# code, but the solution is tricky!
def my_rotate(arr, offset=1)
  if offset >= 0
    num = offset % arr.length
  else
    num = arr.length - offset.abs % arr.length
  end
  return arr.drop(num) + arr.take(num)
end
