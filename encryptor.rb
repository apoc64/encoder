class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
   end

   def encrypt_letter(letter, rotation)
     cipher_for_rotation = cipher(rotation)
     cipher_for_rotation[letter]
   end

   def encrypt(string, rotation)
     letters = string.split("")

     results = []
     letters.each do |letter|
       encrypted_letter = encrypt_letter(letter, rotation)
       results.push(encrypted_letter)
     end

     results.join
   end

   def decrypt(string, rotation)
     encrypt(string, -rotation)
   end

   def encrypt_file(filename, rotation, encrypting = true)
     # Create file handle to the input file
     input_file = File.open(filename, "r")
     # read text of file
     message_to_encrypt = input_file.read
     # Create name for output file
     if !encrypting
       output_filename = filename.gsub("encrypted", "decrypted")
     else
       output_filename = "#{filename}.encrypted"\
     end 
     output_file = File.open(output_filename, "w")
     # Create output file handle
     # Write out the text
     output_file.write(encrypt(message_to_encrypt, rotation))
     # Close the file
     input_file.close
     output_file.close
   end

   def decrypt_file(filename, rotation)
     encrypt_file(filename, -rotation, false)
   end

end
