# This code creates an IAM user, assigns an access key, 
# grants the user the ability to assume any role, 
# and applies a tag to the user.
resource "aws_iam_user" "Tunde" {
  name = "Tunde"
  path = "/system/"

  tags = {
    tag-key = "Tom"
  }
}

#This code block creates an access key for the IAM user "Tunde". 
#The aws_iam_user.Tunde.name expression references the name attribute of the aws_iam_user resource created earlier.
resource "aws_iam_access_key" "Tunde" {
  user = aws_iam_user.Tunde.name
}

#This code block creates an IAM policy document that allows the "Tunde" user to assume any role. 
#It uses the aws_iam_policy_document data source to define the policy document. In this case, 
#it allows the "sts:AssumeRole" action on any resource ("*").
data "aws_iam_policy_document" "Tunde_ro" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

# This code block attaches the IAM policy document defined in the previous step to the IAM user "Tunde". 
#It creates an IAM user policy named "test" and associates it with the "Tunde" user. 
#The policy attribute references the JSON representation of the policy document defined in the data.aws_iam_policy_document.Tunde_ro data source.
resource "aws_iam_user_policy" "Tunde_ro" {
  name   = "test"
  user   = aws_iam_user.Tunde.name
  policy = data.aws_iam_policy_document.Tunde_ro.json
}