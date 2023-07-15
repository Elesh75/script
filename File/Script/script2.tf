#A terraform code to read a text file containing list of filenames with extensions and 
# determine which names are unique per row, ignoring their file extensions

data "local_file" "filenames" {
  filename = "../Example"
}

locals {
  filenames_without_extension = [
    for filename in split("\n", data.local_file.filenames.content) : replace(basename(filename), ".[a-zA-Z]+", "")
  ]
}

output "unique_names_output" {
  value = local.filenames_without_extension
}