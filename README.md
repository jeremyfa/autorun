# autorun

Utilities to create statically typed events, observable objects and autorun callbacks in Haxe language

# How to use

For now, you can [check out this working example](src/autorun/test/) that uses `events`, `observable` properties and `autorun` callbacks.

## Create a statically typed event

Following is a most simple example of creating custom events in your class:

```haxe
package;

import autorun.Events;

class Foo implements Events {

    @event function bar(someParam:Int);

    public function new() {}

}
```

This will generate `onBar()`, `onceBar()`, `listensBar()` and `emitFBar()`.

As you can see, we are taking advantage of `Haxe`'s function syntax to create statically typed events with typed parameters.

By default, `emitBar()` is private and can only be called by the class code it is from. It can become public by simply adding `public` to the event declaration:

```haxe
@event public function bar(someParam:Int);
```

## Emit an event

Following up with our `Foo` class, we can emit an event by calling `emitFoo()`. Beware to respect the typing declared before (there is an `Int` typed param).

```haxe
var foo = new Foo();
foo.emitBar(42);
```

## Listen to an event

Emitted event can be listend to. Let's say we got our `foo` object. We can listen to its `bar` event from another place in the code:

```haxe
foo.onBar(function(param:Int) {
    // Will be called everytime `bar` event is emitted by `foo`
    trace('bar event, param=$param');
});
```

