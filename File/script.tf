locals {
  filenames = ["Rate.txt", "Tree.jpg", "Ink.docx", "Kite.rpg"
  ]
}

resource "local_file" "filenames" {
  content  = join("\n", local.filenames)
  filename = "./Example"
}

output "filenames_output" {
  value = local.filenames
}
