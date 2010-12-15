class Talk < ActiveRecord::Base
  has_many :feedbacks, :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :contributors, :through => :contributions, :source => :user
  has_one :suggestion, :class_name => 'Contribution', :conditions => {:kind => 'suggest'}
  has_one :suggester, :through => :suggestion, :source => :user

  validates :title, :presence => true, :length => {:within => 5..300}
  validates :suggester, :presence => true

  [:abstract, :outline, :why_its_interesting].each do |optional_text_attribute|
    validates optional_text_attribute, :length => {:minimum => 10, :allow_blank => true}
  end
end
