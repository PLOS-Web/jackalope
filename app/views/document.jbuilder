json.array! @documents do |document|
  json.(document, :doi, :title, :short_title, :category, :published_at)
  if document.abstract && document.abstract.split.size > 2
    json.abstract document.abstract
  else
    json.abstract nil
  end
  if document.blurb
    json.blurb document.blurb
  end
  json.authors document.authors.order(:rank, :lastname, :firstname), :rank, :firstname, :lastname
end
