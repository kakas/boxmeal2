class GrouponHost < ActiveRecord::Base

  belongs_to :user
  belongs_to :groupon

end
