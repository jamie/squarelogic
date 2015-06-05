require 'mathdoku'

class SquareLogic < Mathdoku
  def equals(value, v1)
    constrain(v1) { |a| a == value }
  end

  def inequality(smaller, greater)
    constrain(smaller, greater) { |a,b| a < b }
  end

  def sequence(*vars)
    constrain(*vars) { |*args| args.sort == (args.min .. args.max).to_a }
  end
end
