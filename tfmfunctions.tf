#1. COUNT as meta argument
/*resource "aws_iam_user" "example" {
  count = 3 # this will create 3 iam user for us but this won't work when we are trying to create with diff names 
  name = "Vivian.${count.index}"
}*/

/*resource "aws_iam_user" "example" {
  count = length(var.user_names) # WE use a length function here so instead of just creating with the same name and using just index to differentiate
  name = var.user_names[count.index]         # different name will be used and will only create 4 reources (i.e length(var.user_names))
}*/                                          # using functions with count meta argument is a better option

variable "user_names" {
type = list(string)
default = ["Vivian", "Mat", "George"]
}

/*output "first_arn" {
 value = aws_iam_user.example[0].arn
}
                                 # This is still using Count to get our output which isn't very good
output "all_arn" {
 value = aws_iam_user.example[*].arn
}*/

#2. LOOP WITH FOR_EACH - only loops over sets and maps ( this is a better option)

resource "aws_iam_user" "example" {
 for_each = toset(var.user_names)  # converting our variable list to set 
 name = each.key # or each.value  # Each name in our variable set is now considered as key/value 
}

/*output "all_users" {
 value = aws_iam_user.example  # outputing all our user
}*/

/*output "all_user_arns" {
value = values(aws_iam_user.example)[*].arn  # We used a Value function here Since arn is a key = value pair and what we need is the values of all user arns
}*/                                           # We can replace the * with a specific user to get the arn of that specific user.

/*output "all_user_arns" {
value = values(aws_iam_user.example)[*].arn
}

OR

output "all_user_arns" {
value = values(aws_iam_user.example)[2].arn  # For the 2nd user
}


output "selected_user_arns" {
  value = values(aws_iam_user.users)[
    if contains(["user1", "user2"], keys(aws_iam_user.users)["2"])
  ].arn
}*/ # The Contains function checks if the current user key (keys(aws_iam_user.for_each)[count.index]) exists in the list of desired user keys (i.e., ["Vivian", "Mat"]). If the condition is true, it includes the user's ARN in the output. 

#3. FOR LOOP
output "upper_names" {
value =  [ for name in var.user_names : upper(names) if length(name) < 4]  # This is a For funtion it will loop over the variable list(names)and give us upper case if the length of the name is < 4
}

variable "hero_thousand_faces" {
description = "map"
type        = map(string)
default = {
neo      = "hero"
trinity  = "love interest"
morpheus = "mentor"
}
 }

output "bios" {
value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]  # looping over maps thats why we pass name, role (i.e key and value)
}               # This will output for us in list cause our value is in []

output "upper_roles" {
value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }   # This is a usecase
}

#{ for name in var.user_names : key => value } # This will loop over a list and return output as map
#{ for name, role in var.user_names : key => value }  # This will loop over a map and reeturn output as map

#4. Conditional expressions - ternary syntax - returns bool value
#condition ? true : false

resource "aws_iam_user" "ternary" {
count = var.check && length(var.user_names) > 0 && length(var.group) > 0 ? length(var.user_names) : 0  # if all the conditions set are true then this will create this resource for us using length(var.user_names) as the value of our count meta argument
name = var.user_names[count.index]                        # But if one of the conditions is false then it won't give us the value and as a result won't create the resource
}

variable "check" {
type = bools
default = true   # If this is false our resource won't be created because var.check is passed as a condition for the resource to be created 
}

variable "group" {
type = list(string)
default = [ "dev", "prod", "uat"]
}
