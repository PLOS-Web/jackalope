require 'spec_helper'
require_relative '../../app/models/em'


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

  it "can paginate" do
    docs = Document.paginated(per_page: 50, page: 0)
    expect(docs.length).to eq(50)
  end

  it "can paginate and order" do
    docs = Document.order('')
  end

  it "possibly has a blub" do
    doc = Document.first
    doc.should respond_to(:manuscript_details)
  end

  describe "after_published_at_by" do
    it "grabs only articles that have been published between now and a specificed time ago" do
      seconds = 14*(24*60*60)
      docs = Document.after_published_at_by(seconds)
      num_docs = docs.length
      num_docs.should_not eq(0)

      docs.where('actual_online_pub_date <= ?', Time.now).length.should eq(num_docs)
      docs.where('actual_online_pub_date >= ?', Time.now - seconds).length.should eq(num_docs)
    end
  end

  describe "before_published_at_by" do
    it "grabs articles that will be published between now and a specified time from now" do
      seconds = 14*(24*60*60)
      docs = Document.before_published_at_by(seconds)
      num_docs = docs.length
      num_docs.should_not eq(0)

      docs.where('actual_online_pub_date >= ?', Time.now).length.should eq(num_docs)
      docs.where('actual_online_pub_date <= ?', Time.now + seconds).length.should eq(num_docs)
    end
  end


end
