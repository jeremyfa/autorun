package autorun;

/** A Destroyable instance is an object that can notify when it
    gets destroyed so that bound events automatically get removed
    by `autorun` event system. */
interface Destroyable {

    /** Whether this object has been destroyed. */
    var destroyed:Bool;

    /** Destroy this object. Implementing classes should free everything
        here and call onDestroy() callbacks in that situation. */
    function destroy():Void;

    /** Add a callback that will be called when this object is destroyed and then removed. */
    function onceDestroy(?owner:Destroyable, handleDestroy:Void->Void):Void;

    /** Remove a callback previously added with `onDestroy`/`onceDestroy` */
    function offDestroy(?handleDestroy:Void->Void):Void;

} //Destroyable
