class Location < ActiveRecord::Base

  def concat_location
    return self.city + ", " + self.state
  end
end
