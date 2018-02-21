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

end
