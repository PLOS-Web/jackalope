require_relative '../db_config'

class Document < ActiveRecord::Base
  self.primary_key = 'documentid'
  has_many :authors, foreign_key: 'documentid',
           conditions: proc { [ " revision = ? ", self.revision ]}
  alias_attribute :title, :dtitle
  alias_attribute :abstract, :abstract_text
  alias_attribute :published_at, :actual_online_pub_date

end

class Author < ActiveRecord::Base
  self.primary_key = 'authid'
  self.table_name = 'authors'
  belongs_to :document, foreign_key: 'documentid'
end

