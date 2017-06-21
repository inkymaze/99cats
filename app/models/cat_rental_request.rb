class CatRentalRequest < ApplicationRecord
  validates :status, presence: true, inclusion: { in: %w(APPROVED DENIED PENDING)}
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    # CatRentalRequest.group(:cat_id).having("COUNT(cat_id) > 1")

    CatRentalRequest.where.not(id: self.id).where(cat_id: self.cat_id).where(<<-SQL, start_date: start_date, end_date: end_date)
      NOT (:end_date < start_date OR :start_date > end_date )
    SQL
  end

  def overlapping_approved_requests
    # CatRentalRequest.where("status = 'APPROVED' AND  IN #{overlapping_requests}",)
    overlapping_requests.where(status: "APPROVED")
  end

  def does_not_overlap_approved_requests
    
  end


end
