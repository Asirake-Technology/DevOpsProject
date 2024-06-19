 Define the provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Generate a new private key
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a key pair using the public key from the generated private key
resource "aws_key_pair" "generated_key" {
  key_name   = "generated-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/generated-key.pem"
  file_permission = "0400" # Only owner can read
}