class Filter
  TOTAL_TIME = 1000
  N = 1024
  W_MAX = 2100
  A_MAX = 10
  STEP = 1

  attr_reader :signal
  attr_accessor :m

  def initialize(m=6)
    @m = m > 0 ? m : 6
    a = []
    w = []
    phi = []
    0.upto(@m) do |i|
      a[i] = rand * A_MAX
      w[i] = W_MAX / @m * ( i + 1 )
      phi[i] = rand * Math::PI * 2
    end
    functor = ->(t){(0..@m).inject{|sum, i| sum += a[i] * Math.sin(w[i] * t + phi[i]) }}
    @signal = (1..N).map{|i| functor[i]}
  end

  def filter(as, bs)
    result = []
    0.upto(N-1){ |n|
      y = 0
      as.each_with_index{|asi,i| 
        y += @signal[n-i] * asi if (n-i) >= 0
      }

      1.upto(bs.size){|i|
        y -= result[n-i] * bs[i-1] if (n - i) < result.size && (n - i) >= 0
      }
      result << y
    }
    result
  end

end
