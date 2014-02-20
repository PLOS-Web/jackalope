require 'spec_helper'
require_relative '../../lib/models/em'


describe "Document" do

  it "can retrieve an article by doi" do
    doi = "10.1371/journal.pbio.1001788"
    doc = Document.where(doi: doi).first
    #p doc
    expect(doc[:doi]).to eq(doi)
  end

  it "can retrieve multiple articles by doi" do
    dois = []
    (1001000..1001020).each do |i|
      dois << "10.1371/journal.pbio." + i.to_s
    end
    docs = Document.where(:doi => dois)
    expect(docs.order(:doi).map(&:doi)).to eq(dois)
  end

  it "has authors" do
    doi = "10.1371/journal.pbio.1001788"
    doc = Document.where(doi: doi).first

    authors = doc.authors.order(:rank).all
    #p authors
    authors[0].should respond_to(:lastname)
  end

end
