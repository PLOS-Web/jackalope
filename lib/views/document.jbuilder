json.array! @documents do |document|
  json.document do
    json.(document, :doi, :category, :actual_online_pub_date)
  end
end