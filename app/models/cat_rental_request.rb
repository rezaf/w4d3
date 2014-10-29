class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
                               message: "Not a valid status!" }
  validate :overlapping_approved_requests
  after_initialize :default_status
  
  belongs_to :cat                         
  
  def approve!
    self.transaction do
      
      self.update(status: "APPROVED")
    end
  end
  
  protected
  def default_status
    self.status ||= "PENDING"
  end
  
  private
  def overlapping_requests
    CatRentalRequest
      .where("((? BETWEEN start_date AND end_date) OR (? BETWEEN start_date AND end_date))", 
        self.start_date, self.end_date)
      .where("cat_id = ?", self.cat_id)
  end
  
  def overlapping_approved_requests
    if overlapping_requests.where("status = ?", "APPROVED").count > 0
      errors[:approvals] << "Date conflict!"
    end
  end
  
  def overlapping_pending_requests
    if overlapping_requests.where("status = ?", "PENDING").count > 0
      
    end
  end
end
