describe "Memory management" do
  it "keeps zero weak refs zeroed if referenced objects are gone" do
    zwr = MMAutoreleased -> {
      obj = "hello"
      zwr = MAZeroingWeakRef.refWithTarget(obj).retain # that what happens if you neer to be smarter than runtime!
      obj = nil
      zwr
    }
    print "got weakRef #{zwr.class}"
    zwr.target.should == nil
  end

  it "keeps zero weak refs alive if referenced objects are alive" do
    obj = "hello"
    zwr = obj.weak!
    zwr.length.should == 5
  end

  it "works with the example code" do
    class Test
      def method
        "hello"
      end
    end

    t = MMAutoreleased -> {
      t = Test.alloc.init.retain
    }
    wt = t.weak!

    wt.method.should == "hello"

    t.release
    t.release # this is effectively first time I do that in all my ObjC practice!
    t = nil

    wt.method.should == nil
  end
end
