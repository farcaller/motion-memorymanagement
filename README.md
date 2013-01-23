# Motion::MemoryManagement

This gem provides weak references and autorelease pools for your ruby code!

## Installation

### Update your Rakefile

```ruby
require 'motion-memorymanagement'
```

## Usage

Motion::MemoryManagement is effectively a stripped version of [https://github.com/mikeash/MAZeroingWeakRef](MAZeroingWeakRef), all the appropriate classes are available in RubyMotion.

It also provides two helper methods to simplify usage for weak references and weak proxy objects.

Finally, it provides a way to wrap some ruby code in ```@autorelease { ... }``` block (I expect you know what you're doing!).

### MAZeroingWeakRef

```MAZeroingWeakRef``` is the primary interface to use.

```ruby
# make reference
obj = self.some_data
weak_ref = obj.to_weakref # same as MAZeroingWeakRef.refWithTarget(obj)

# use reference
weak_ref.target # will become nil automagically as soon as obj is "garbage-collected"
```

### MAZeroingWeakProxy

```MAZeroingWeakProxy``` is effectively a proxy class around your object. This may or may
not be what you want, because the message dispatch goes right through Objective-C runtime.
If unsure, use ```MAZeroingWeakRef```.

```ruby
# make reference
obj = self.some_data
weak_ref = obj.to_weakproxy # same as MAZeroingWeakProxy.proxyWithTarget(obj)

# use reference
weak_ref.method_of_obj # if 'obj' is gone, it will be same as calling method on nil,
                       # that is, it will do nothing and return nil
```

### MAWeakArray and MAWeakDictionary

That are mutalbe array and dictionary with added feature that the stored objects are
weak-referenced (i.e. objects on array or keypairs in dictionary may be zeroed out).

### Notes

By default, all objects created in ruby scope are put into nearest local autorelease pool.
Effectively meaning that no object would go away until current method ends returning control
to the event loop.

Lots of thanks to Mike Ash for his MAZeroingWeakRef!
