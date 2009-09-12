#! /usr/bin/env ruby19
$-w = true
######################################################################
# Each character on a computer is assigned a unique code and the
# preferred standard is ASCII (American Standard Code for Information
# Interchange). For example, uppercase A = 65, asterisk (*) = 42, and
# lowercase k = 107.
#
# A modern encryption method is to take a text file, convert the bytes
# to ASCII, then XOR each byte with a given value, taken from a secret
# key. The advantage with the XOR function is that using the same
# encryption key on the cipher text, restores the plain text; for
# example, 65 XOR 42 = 107, then 107 XOR 42 = 65.
#
# For unbreakable encryption, the key is the same length as the plain
# text message, and the key is made up of random bytes. The user would
# keep the encrypted message and the encryption key in different
# locations, and without both "halves", it is impossible to decrypt
# the message.
#
# Unfortunately, this method is impractical for most users, so the
# modified method is to use a password as a key. If the password is
# shorter than the message, which is likely, the key is repeated
# cyclically throughout the message. The balance for this method is
# using a sufficiently long password key for security, but short
# enough to be memorable.
#
# Your task has been made easy, as the encryption key consists of
# three lower case characters. Using cipher1.txt (right click and
# 'Save Link/Target As...'), a file containing the encrypted ASCII
# codes, and the knowledge that the plain text must contain common
# English words, decrypt the message and find the sum of the ASCII
# values in the original text.
######################################################################

# Assume that the input data is in the current directory.
cipher = ''
File::open('cipher1.txt') do |file|
  cipher = file.readline
end
cipher = cipher.split(',').map &:to_i

# Generate or enumerate all of the 3 lowercase character terms.
def each_key
  if block_given?
    a = 'a'.ord
    z = 'z'.ord
    a.upto(z) do |left|
      a.upto(z) do |middle|
        a.upto(z) do |right|
          yield [left, middle, right]
        end
      end
    end
  else
    self.to_enum(:each_key)
  end
end

# Process the cipher with the specified key, returning the result
# string.
def decode(cipher, key)
  key = key.dup
  plain = cipher.map do |ch|
    x = key.shift
    key <<= x
    ch ^ x
  end
  plain.pack 'c*'
end

# My first guess was to limit the expression to results that only
# matched printable characters.  This results in a couple of hits,
# show the only one with the word 'the' in it.
answer = each_key do |key|
  text = decode(cipher, key)
  next unless text =~ /^[ -z]*$/
  next unless text =~ /the/
  break text
end

p answer.unpack('c*').reduce(:+)
