# Create EFS File System
resource "aws_efs_file_system" "GeneralFileSystem" {
    creation_token = "FSPolicyToken_v1"
  
}

# Create mount target
resource "aws_efs_mount_target" "GeneralMountTarget" {
    file_system_id = aws_efs_file_system.GeneralFileSystem.id
    subnet_id = aws_subnet.GeneralSubnet.id
  
}
# Create EFS Backup Policy
resource "aws_efs_backup_policy" "GeneralBackupPolicy" {
    file_system_id = aws_efs_file_system.GeneralFileSystem.id       
    
    backup_policy {
        status = "ENABLED"
    }
}
#Create an EFS Access Point
#resource "aws_efs_access_point" "test" {
#  file_system_id = aws_efs_file_system.foo.id
#}

# Create EBS block storage
#data "aws_ebs_volume" "ebs_volume" {
#  most_recent = true
#
#  filter {
#    name   = "volume-type"
#    values = ["gp2"]
#  }
#
#  filter {
#    name   = "tag:Name"
#    values = ["Example"]
#  }
#}


