package autorun;

class Autorun extends Entity {

/// Current autorun

    public static var current:Autorun = null;

/// Events

    @event function reset();

/// Properties

    var onRun:Void->Void;

    public var invalidated(default,null):Bool = false;

/// Lifecycle

    public function new(onRun:Void->Void) {

        this.onRun = onRun;

        // Run once to create initial binding and execute callback
        run();

    } //new

    public function run():Void {

        // Nothing to do if destroyed
        if (destroyed) return;

        // We are not invalidated anymore as we are resetting state
        invalidated = false;

        // Unbind everything
        emitReset();

        // Set current autorun to self
        var prevCurrent = current;
        current = this;

        // Run (and bind) again
        onRun();

        // Restore previous current autorun
        current = prevCurrent;

    } //run

    inline public function invalidate():Void {

        if (invalidated) return;
        invalidated = true;

        _tick.onceTick(run);

    } //invalidate

/// Tick

    static var _tick:Tick = new Tick();

    /** This must be called at every frame of the application to process
        invalidated autoruns. This would typically mean you should add
        `autorun.Autorun.tick();` somewhere in your update loop. */
    public static function tick():Void {

        @:privateAccess _tick.emitTick();

    } //tick

    /** If your application doesn't have any place where you can call `tick()`,
        You can just schedule an `autoTick` at a regular interval (in seconds).
        This is the easiest way to setup autoruns but if your application has a frame/update loop,
        it is recommended to call `tick()` explicitly at every frame instead. */
    public static function autoTick(interval:Float):Void {

        tick();

        haxe.Timer.delay(function() autoTick(interval), Std.int(interval * 1000));

    } //autoTick

} //Autorun
