terraform {
    backend "s3" {
        bucket         = "tf-challenge-s3b-dereck"        
        key            = "state/terraform.tfstate"      
        region         = "us-east-2"                    
        dynamodb_table = "terraform-locks"           
        encrypt        = true
    }
}
