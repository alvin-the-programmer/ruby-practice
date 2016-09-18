class Card
  attr_reader :value, :face_up

  def initialize(value)
    @value = value
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def face
    return value if face_up
    'X'
  end
  
end
