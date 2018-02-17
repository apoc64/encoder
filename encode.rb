# String of all supported characters
@char_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,.!@*$%?/<>()-=+':; "
@decoding_hash = {}
@encoding_hash = {}

def char_array #makes an array from the string of all supported characters
  char_array = [] #put those letters in an array Eliminate - local inside method?
  @char_string.each_char { |char| char_array.push(char) } #@char_string.split("") would work?
  char_array
end #char_array

def generate_key_hashes(key) # generates two hashes given a scrambled array
  # Validate key?
  character_list_length_from_zero = @char_string.length - 1
  # produce hashes of the characters of the orig and the scramble
  (0 .. character_list_length_from_zero).each do |index|
    @decoding_hash[key[index]] = char_array[index]
    @encoding_hash[char_array[index]] = key[index]
  end # making hashes from each index position
end # generate keys

def random_key # produces a scrambled array
  scrambled_char_array = char_array.shuffle
  scrambled_char_array
end #random_key

def key_array_from_string(key) # produces an array from a key string
  scrambled_char_array = []
  key.each_char { |char| scrambled_char_array.push(char) }
  scrambled_char_array
end #key_array_from_string

def output_key_string #creates a string key to output
  encoding_array = []
  output_key_string = ""
  @char_string.each_char { |char| encoding_array.push(@encoding_hash[char]) }
  encoding_array.each { |char| output_key_string.concat(char) }
  output_key_string
end #output_key_string

def code_message(message, coding_hash) #Codes a message based on a hash. May need seperate encode/decode methods with added complexity/asymetry
  if validate_message(message)
    coded_message = ""
    coding_array = []
    message.each_char { |char| coding_array.push(coding_hash[char]) } #Validate each character?
    coding_array.each { |char| coded_message.concat(char) }
    coded_message
  else
    "Message contains invalid characters. Cannot decode."
  end #message validate
end #code_message

def validate_message(message) #returns a bool - true if no invlaid characters
  valid = true
  message.each_char do |char|
    if !@char_string.include?(char)
      valid = false
    end
  end #each char in message
  valid
end #validate

generate_key_hashes(random_key) #start with a random key

user_choice = ""
while user_choice != '6' #User interaction loop
  puts "What do you want to do? [ 1:Encode a message,  2:Decode a message,  3:Output Current Key,  4:Input New Key,  5:Generate New Key,  6:Exit ]"
  user_choice = gets.chomp
  if user_choice == '1' #encode
    puts "What message would you like to encode?" #Validate message characters?
    encoded_message = code_message(gets.chomp, @encoding_hash)
    puts encoded_message
  elsif user_choice == '2' #decode
    puts "What message would you like to decode?"
    decoded_message = code_message(gets.chomp, @decoding_hash)
    puts decoded_message
  elsif user_choice == '3' #Output current key
    puts output_key_string
  elsif user_choice == '4' #Input new key
    puts "Enter new key:" #Validate key?
    generate_key_hashes(key_array_from_string(gets.chomp))
  elsif user_choice == '5' #Generate new key
    generate_key_hashes(random_key)
    puts "New key generated"
  end # if user_choice == ?
end # while user doesn't exit

#Increased complexity?
