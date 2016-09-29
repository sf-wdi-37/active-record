class Talk < ActiveRecord::Base
  validates :start_time, presence: true
  validates :topic, length: { in: 3..100 }

  after_initialize :set_default_values


  def pretty_start_time
    self.start_time.strftime("%I:%M%p, %m/%d/%Y")
  end


  protected

  def set_default_values
    # set a duration *only if* there isn't one after initialize
    self.duration ||= 30
    self.topic ||= "TBD"
  end


end
