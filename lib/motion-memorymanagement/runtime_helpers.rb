class Object
  def to_weakref
    MAZeroingWeakRef.refWithTarget(self)
  end

  def to_weakproxy
    MAZeroingWeakProxy.proxyWithTarget(self)
  end
end
