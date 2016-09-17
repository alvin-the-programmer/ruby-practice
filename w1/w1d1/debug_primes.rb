
def prime?(num)
  debugger
  return false if num < 2

  (2..num - 1).each do |idx|
    if num % idx == 0
      return false
    end
  end

  return true
end

def primes(num_primes)
  primes = []
  num = 1

  while primes.count < num_primes
    primes << num if prime?(num)
    num += 1
  end

  return primes
end

if __FILE__ == $PROGRAM_NAME
  puts primes(5)
end
