class Object
  def weak!
    MAZeroingWeakProxy.proxyWithTarget(self)
  end
end
