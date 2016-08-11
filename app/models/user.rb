class User < ActiveRecord::Base

  scope :find_by_year, ->(year) \
    { where("cast(strftime('%Y', birthdate) as int) = ?", year)  }
  scope :find_by_month, ->(month) \
    { where("cast(strftime('%m', birthdate) as int) = ?", month) }

end
