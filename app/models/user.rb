class User < ActiveRecord::Base

  has_many :emails
  belongs_to :typeable, :polymorphic => true


end
