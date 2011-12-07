class User < ActiveRecord::Base
  belongs_to :typeable, :polymorphic => true
end
