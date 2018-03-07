package autorun;

/** A convenience class that we can inherit from
    with a default `Destroyable` implementation. */
class Entity implements Events implements Destroyable {

    @event function destroy();

    public var destroyed:Bool = false;

    public function destroy():Void {

        if (destroyed) return;
        destroyed = true;

        emitDestroy();

    } //destroy

} //Entity
