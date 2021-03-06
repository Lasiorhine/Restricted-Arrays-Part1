require 'pry'
require_relative 'restricted_array.rb'
# RestrictedArray can be created using a specified size, or a random size in
# the range of 1-20 will be chosen for you.
# All values are integers in the range of 1-221.
# RestrictedArray cannot be resized.

# Calculates the length of the restricted array. All values are integers.
# The restricted_array is terminated by 'nil' i.e. array[length] = nil
def length(array)
  count = 0
  until array[count] == nil
    count = count + 1
  end
  return count
end

# Prints each integer values in the array
def print_array(array)
  count = 0
  until array[count] == nil
    print array[count]
    count += 1
  end
end
#
# For an unsorted array, searches for 'value_to_find'.
# Returns true if found, false otherwise.
def search(array, length, value_to_find)
  value_found = false
  unless value_found == true
    index = 0
    length.times do
      if array[index] == value_to_find
        value_found = true
      else
        index += 1
      end
    end
  end
  return value_found
end
#

def find_first_non_nil (array, length)
  # I made this to help my find_largest and find_smallest
  # methods to not break when arrays have values of nil
  # at one or more positions.
  # Time complexity for this is linear, space complexity is constant.
  first_non_nil = false
  index = 0
  until first_non_nil != false
    length.times do
      if array[index] != nil
        first_non_nil = index
      else
        index +=1
      end
    end
  end
  return first_non_nil
end

# Finds and returns the largest integer value the array
# Assumes that the array is not sorted.
def find_largest(array, length)
  first_non_nil = find_first_non_nil(array, length)
  if array[0] == nil
    largest = array[first_non_nil]
  else
    largest = array[0]
  end
  index = 0
  length.times do
    if array[index] == nil
    elsif array[index] > largest
      largest = array[index]
    end
    index += 1
  end
  return largest
end

# Finds and returns the smallest integer value in the array
# Assumes that the array is not sorted.
def find_smallest(array, length)
  first_non_nil = find_first_non_nil(array, length)
  nil_count = first_non_nil - 0
  smallest = array[first_non_nil]
  index = 0
  length.times do
    if array[index] == nil
      nil_count += 1
    elsif array[index] < smallest
      smallest = array[index]
    end
    index += 1
  end
  if nil_count > 0
    smallest = nil
  end
  return smallest
end
#


#
# Reverses the values in the integer array in place
def reverse(array, length)
  ##ORIGINAL VERSION: NOT A REVERSE IN PLACE
  # reversed_array = []
  # og_index = length - 1
  # tgt_index = 0
  # unless og_index == -1
  #   length.times do
  #     reversed_array[tgt_index] = array[og_index]
  #     tgt_index += 1
  #     og_index -= 1
  #   end
  # end
  # return reversed_array

  # REVERSE IN PLACE:
  origin_index = length - 1
  target_index = 0
  temp = nil
  (length / 2).times do
    temp = array[target_index]
    array[target_index] = array[origin_index]
    array[origin_index] = temp
    origin_index -= 1
    target_index += 1
  end
  return array
end

#
# For an array sorted in ascending order, searches for 'value_to_find'.
# Returns true if found, false otherwise.

def binary_search(array, length, value_to_find)
  low_index = 0
  high_index = length - 1
  search_position = (low_index + length / 2)
  found = false
  ((Math.log2(length).to_i) + 1).times do #Adds 1 to account for lengths where the actual log2 is a decimal number.
    unless found == true
      if array[search_position] == value_to_find
        found = true
        return found
      elsif array[search_position] < value_to_find
        low_index = search_position
        search_position = (low_index + (high_index + 1)) / 2
      elsif array[search_position] > value_to_find
        high_index = search_position
        search_position = (low_index + high_index) / 2
      end
    end
  end
  return found
end


# Version of binary search with 1 less variable -- work in pogress.  NOT FUNCTIONAL NOW.


# def binary_search(array, length, value_to_find)
#   target_index = length - 1
#   found = false
#   if array[0] == value_to_find || array[target_index] == value_to_find
#     found = true
#     return found
#   else
#     step_size = target_index / 2
#   end
#
#   ((Math.log2(length).to_i) + 1).times do
#     unless found == true
#       if array[target_index] == value_to_find
#         found = true
#         return found
#       else
#         if value_to_find < array[target_index]
#           target_index -= step_size
#         elsif value_to_find > array[target_index]
#           target_index += step_size
#         end
#         step_size = step_size / 2
#       end
#     end
#   end
#   return found
# end








# Helper method provided to sort the array in ascending order
# Implements selection sort
# Time complexity = O(n^2) since to find the correct value to be in a given location,
# all the remaining elements are visited. This is done for each location.
# (nested loop of size n each)
# Space complexity = O(1) since the additional storage needed does not depend
#                    on input array size.

def sort(array, length)
  length.times do |index| # outer loop - n elements
    min_index = index # assume index is where the next minimally value is
    temp_index = index + 1 # compare with values at index+1 to length-1
    while temp_index < length # inner loop - n-1 elements
      if array[temp_index] < array[min_index] # found a new minimum, update min_index
        min_index = temp_index
      end
      temp_index += 1 # move to next index
    end
    if min_index != index # next minimum value is not at current index, swap
      temp = array[min_index]
      array[min_index] = array[index]
      array[index] = temp
    end
  end
end

## --- END OF METHODS ---
