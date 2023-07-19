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

resource "aws_iam_access_key" "Tunde" {
  user = aws_iam_user.Tunde.name
}

data "aws_iam_policy_document" "Tunde_ro" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "Tunde_ro" {
  name   = "test"
  user   = aws_iam_user.Tunde.name
  policy = data.aws_iam_policy_document.Tunde_ro.json
}