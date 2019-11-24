class Memory < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :space, optional: true
  belongs_to :journey, optional: true
end