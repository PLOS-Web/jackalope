require_relative '../db_config'

class Document < ActiveRecord::Base
  self.primary_key = 'documentid'
  has_many :authors, foreign_key: 'documentid',
           conditions: proc { [ " revision = ? ", self.revision ]}
  has_many :manuscript_details, foreign_key: 'documentid',
           class_name: 'ManuscriptDetail',
           conditions: proc { [ " amd_id = 10 "] } #'Blurb' id, ONLY CORRECT FOR BIO (15 for med)
  alias_attribute :title, :dtitle
  alias_attribute :abstract, :abstract_text
  alias_attribute :published_at, :actual_online_pub_date

  def self.default_scope
    where('DOI IS NOT NULL').where('ACTUAL_ONLINE_PUB_DATE IS NOT NULL')
  end

  def self.paginated(per_page: 50, page: 0)
    limit(per_page).offset(page*per_page)
  end

  def self.after_published_at_by(secs)
    where actual_online_pub_date: (Time.now-secs..Time.now)
  end

  def self.before_published_at_by(secs)
    where actual_online_pub_date: (Time.now..Time.now+secs)
  end

  def blurb
    if manuscript_details.first
      manuscript_details.first.notes_value
    end
  end
end

class Author < ActiveRecord::Base
  self.primary_key = 'authid'
  self.table_name = 'authors'
  belongs_to :document, foreign_key: 'documentid'
end

class ManuscriptDetail < ActiveRecord::Base
  self.table_name = 'additional_manuscript_detail_values'
end

