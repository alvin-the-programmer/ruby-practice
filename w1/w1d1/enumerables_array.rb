class Array
  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end

    return self
  end

  def my_select(&prc)
    selected = []

    self.my_each do |item|
      selected << item if prc.call(item)
    end

    return selected
  end

  def my_reject(&prc)
    selected = []

    self.my_each do |item|
      selected << item if !prc.call(item)
    end

    return selected
  end

  def my_any?(&prc)
    self.my_each do |item|
      return true if prc.call(item)
    end

    return false
  end

  def my_all?(&prc)
    self.my_each do |item|
      return false if !prc.call(item)
    end

    return true
  end

  def my_flatten
    flattened = []

    self.my_each do |item|
      if item.kind_of?(Array)
        flattened += item.my_flatten
      else
        flattened << item
      end
    end

    return flattened
  end

  def my_zip(*arguments)
    zipped = []

    self.length.times do |i|
      zip = [self[i]]
      arguments.my_each { |argument| zip << argument[i] }
      zipped << zip
    end

    return zipped
  end

  def my_rotate(*arguments)
    number = arguments[0] || 1
    rotated = [] + self

    if number > 0
      number.times do
        rotated << rotated.delete_at(0)
      end
    else
      number = number.abs
      number.times do
        rotated.insert(0, rotated.pop)
      end
    end

    return rotated
  end









end
