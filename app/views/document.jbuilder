json.array! @documents do |document|
  json.(document, :doi, :title, :short_title, :category, :abstract, :published_at)
  json.authors document.authors, :rank, :firstname, :lastname
end
