class Sale < ActiveRecord::Base
  
  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validates :percent_off, presence: true, numericality: true

  # Active Record scope
  def self.active
    self.where("sales.starts_on <= ? AND sales.ends_on >= ?", 
      Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end
end
