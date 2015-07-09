class Phone < ActiveRecord::Base
  belongs_to :vendor

  validates_uniqueness_of :name
  validates_presence_of :name, :diagonal, :vendor_id

  validates :diagonal, numericality: { only_integer: true }
end
