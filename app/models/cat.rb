class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates_date :birth_date, on_or_before: lambda { Date.current }
    # validates_date :birth_date, on_or_before: -> { Date.current }
  
  has_many :cat_rental_requests, :dependent => :destroy
  
  def age
    Date.current - birth_date
  end
end
