resource "aws_db_option_group" "sample" {
  name                 = "sample"
  engine_name          = "mysql"
  major_engine_version = "5.7"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }
}
