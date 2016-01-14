# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

book1 = Book.create(title: "The Universe in a Nutshell", description: "The Universe in a Nutshell is one of Stephen Hawking's books on theoretical physics. It explains to a general audience various matters relating to the Lucasian professor's work, such as Gödel's Incompleteness Theorem and P-branes (part of superstring theory in quantum mechanics).", price: 8.99, quantity_in_stock: 33)
book2 = Book.create(title: "A Brief History of Time", description: "Is a 1988 popular-science book by British physicist Stephen Hawking. It became a bestseller and sold more than 10 million copies in 20 years. It was also on the London Sunday Times bestseller list for more than four years and was translated into 35 languages by 2001", price: 9.99, quantity_in_stock: 25)
book3 = Book.create(title: "On The Shoulders of Giants", description: "On the Shoulders of Giants is a compilation of scientific texts edited and with commentary by the British theoretical physicist Stephen Hawking.", price: 9.99, quantity_in_stock: 50)
book4 = Book.create(title: "My Brief History", description: "My Brief History is a memoir published in 2013 by the English physicist Stephen Hawking. The book recounts Hawkins journey from his post-war London boyhood to his years of international acclaim and celebrity.", price: 7.50 , quantity_in_stock:12 )
book5 = Book.create(title: "Black Holes and Baby Universes and other Essays", description: "This book is a collection of essays and lectures written by Hawking, mainly about the makeup of black holes, and why they might be nodes from which other universes grow.", price: 15 , quantity_in_stock: 44)
book6 = Book.create(title: "The Selfish Gene", description: "The Selfish Gene is a book on evolution by Richard Dawkins, published in 1976. It builds upon the principal theory of George C. Williams's first book Adaptation and Natural Selection.", price: 7.49, quantity_in_stock: 67)
book7 = Book.create(title: "The Extended Phenotype", description: "The Extended Phenotype is a 1982 book by Richard Dawkins in which he introduced a biological concept of the same name. The main idea is that phenotype should not be limited to biological processes such as protein biosynthesis or tissue growth, but extended to include all effects that a gene has on its environment, inside or outside the body of the individual organism.", price: 11, quantity_in_stock: 11)
book8 = Book.create(title: "The Blind Watchmaker", description: "The Blind Watchmaker: Why the Evidence of Evolution Reveals a Universe without Design is a 1986 book by Richard Dawkins in which he presents an explanation of, and argument for, the theory of evolution by means of natural selection.", price: 11.2, quantity_in_stock: 12)
book9 = Book.create(title: "River Out of Eden", description: "River Out of Eden: A Darwinian View of Life is a 1995 popular science book by Richard Dawkins. The book is about Darwinian evolution and includes summaries of the topics covered in his earlier books, The Selfish Gene, The Extended Phenotype and The Blind Watchmaker.", price: 10.99, quantity_in_stock: 2)
book10 = Book.create(title: "The God Delusion", description: "In The God Delusion, Dawkins contends that a supernatural creator almost certainly does not exist and that belief in a personal god qualifies as a delusion, which he defines as a persistent false belief held in the face of strong contradictory evidence.", price: 53.78, quantity_in_stock: 5)
# book11 = Book.create(title: "", description: "", price: 25,3, quantity_in_stock: 10)
# book12 = Book.create(title: "", description: "", price: 32,72, quantity_in_stock: 7)

