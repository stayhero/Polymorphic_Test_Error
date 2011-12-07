class Company < ActiveRecord::Base
  has_many :departments
  has_many :users, through: :departments
  has_many :developers, source_type: 'Developer', source: :typeable  , through: :users
  has_many :designers, source_type: 'Designer', source: :typeable, through: :users
end
