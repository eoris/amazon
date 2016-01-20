module BooksHelper

  def authors_fullname
    @book.authors.map {|n| "#{n.firstname} #{n.lastname}" }.to_sentence
  end

end
