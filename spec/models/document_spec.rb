require 'spec_helper'
require_relative '../../lib/models/em'


describe "Document" do

  it "can retrieve an article by doi" do
    doi = "10.1371/journal.pone.0050000"
    doc = Document.where(doi: doi).first
    #p doc
    expect(doc[:doi]).to eq(doi)
  end

  it "can retrieve multiple articles by doi" do
    dois = []
    (50000..50010).each do |i|
      dois << "10.1371/journal.pone." + i.to_s.rjust(7, '0')
    end
    docs = Document.where(:doi => dois)
    expect(docs.order(:doi).map(&:doi)).to eq(dois)
  end

end
