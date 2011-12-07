class Developer < ActiveRecord::Base
  has_one :user, :as => :typeable
end
