resource "aws_dynamodb_table" "saas_tenants" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "tenant_id"

  attribute {
    name = "tenant_id"
    type = "S"
  }

  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}