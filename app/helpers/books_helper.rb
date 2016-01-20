module BooksHelper

  def authors_link
    @book.authors.map do |n|
     link_to "#{n.firstname} #{n.lastname}", n
    end.to_sentence.html_safe
  end

end

