module SalesHelper
  def active_sales?
    Sale.active.any?
    # Sale.where("sales.starts_on <= ? AND sales.ends_on >= ?", 
    #   Date.current, Date.current).any?
  end

  def active_sale
    Sale.active
  end

end
