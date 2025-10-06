terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-makinko"
    key    = "envs/dev/terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
  }
}
