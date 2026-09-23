resource "random_string" "suffix"{
    length = 6
    upper = false
    special = false
}



resource "aws_s3_bucket" "my_bucket"{
    bucket = "my-random-bucket-${random_string.suffix.result}"

    tags={
        Name = "Dummy bucket"
        Environment = "Dev"
    }
}