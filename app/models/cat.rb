class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates_date :birth_date, on_or_before: lambda { Date.current }
    # validates_date :birth_date, on_or_before: -> { Date.current }
  
  has_many :cat_rental_requests, :dependent => :destroy
  
  belongs_to(
  :owner,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  def age
    Date.current - birth_date
  end
end
