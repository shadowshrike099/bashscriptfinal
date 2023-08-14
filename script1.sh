#!/bin/bash

# Generate RSA Key Pair
openssl genrsa -out user2.pem 2048
openssl rsa -in user2.pem -pubout -out public2.pem

# Create Symbolic Link
ln -s /home/system2/folder2/public2.pem

# Create and Sign Message
echo "hey this is system 1" > message2.txt
openssl rsautl -sign -inkey user2.pem -in message2.txt -out sign2.txt

# Encrypt Signature
openssl enc -des3 -in sign2.txt -out encrypted2.txt

# Encode Encrypted Data in Base64
cat encrypted2.txt | base64 > enc_msg2.txt

# Copy Encoded Message
sudo cp enc_msg2.txt /home/system1/folder1/enc_msg2.txt

# Decrypt and Verify Steps
cat enc_msg1.txt | base64 -d | openssl des3 -k kali -d > final2.txt

sudo openssl rsautl -verify -pubin -inkey public1.pem -in final2.txt -out message1.txt

cat message1.txt
