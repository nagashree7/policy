provider {
    aws_region = "us-east-1"
}

# IAM Password Policy Resource
resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = 14
  require_symbols                = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24  
  hard_expiry                    = false
} 


# Linux EC2 Instance with password history enforcement
resource "aws_instance" "linux_vm" {
  ami           = "ami-053a45fff0a704a47"  
  instance_type = "t2.micro"
  key_name      = "nagu-key"

  user_data = <<EOF
#!/bin/bash
# Enforce password history in Linux
echo "password    requisite     pam_pwhistory.so remember=24" >> /etc/pam.d/common-password
EOF
}
