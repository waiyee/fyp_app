# == Schema Information
# Schema version: 20110228061729
#
# Table name: cities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  nation     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class City < ActiveRecord::Base
  validates :name,  :presence => true,
                    :length   => { :maximum => 200 }
  validates :nation,  :presence => true,
                    :length   => { :maximum => 200 }
  has_many :artists

end
