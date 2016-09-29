class Speaker < ActiveRecord::Base

  validates :email, presence: true

  def speechify(blabber_duration=1)
    FFaker::HipsterIpsum.sentence(blabber_duration)
  end

  # overwrite the to_s method
  def to_s
    # alligator ascii
    "            .-._   _ _ _ _ _ _ _ _\n .-''-.__.-'00  '-' ' ' ' ' ' ' ' '-.\n'.___ '    .   .--_'-' '-' '-' _'-' '._\n V: V 'vv-'   '_   '.       .'  _..' '.'.\n   '=.____.=_.--'   :_.__.__:_   '.   : :\n           (((____.-'        '-.  /   : :\n snd                         (((-'\ .' /\n                           _____..'  .'\n                          '-._____.-'"
  end

end
