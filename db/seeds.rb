# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

Author.create!([{
  name: "Mario Duric",
},
{
  name: "Ivan Ivic"
}])

Book.create!([{
  title: "Soul",
  copies: 3,
  author_id: 1
},
{
  title: "Sunshine",
  copies: 2,
  author_id: 1
},
{
  title: "Lord of the Rings",
  copies: 3,
  author_id: 2
}])

