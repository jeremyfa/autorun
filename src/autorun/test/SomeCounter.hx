package autorun.test;

/** An example of counter with an observable `count` property. */
class SomeCounter implements Observable {

    public function new() {}

    @observe public var count:Int = 0;

} //SomeCounter
