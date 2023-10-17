include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=3.15.1"
}

inputs = {
  bucket = "mandos.net.pl"
  website = {
    redirect_all_requests_to = {
      protocol  = "https"
      host_name = "www.linkedin.com/in/marek-maksimczyk-532a4358/"
    }
  }
}
