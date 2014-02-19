json.array! @documents do |document|
  json.(document, :doi, :dtitle, :short_title, :category, :abstract_text, :actual_online_pub_date)
  json.authors document.current_authors, :rank, :firstname, :lastname
end
