#!/usr/bin/ruby

$firstNo = 1
$secondNo = 1000

def isPrime( inputNo )
  $n = 1
  $prime = false
  while (n < inputNo)
    if (inputNo % n == 0 && inputNo != n && n != 1)
      prime = false
    else
      prime = true
    end
    n++
  end
  return prime
end

while (firstNo <= secondNo) do
  isPrime( firstNo )
end