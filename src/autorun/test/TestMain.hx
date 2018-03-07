package autorun.test;

import autorun.Autorun;
import autorun.Entity;
import autorun.Events;
import autorun.Destroyable;

import haxe.Timer;

class TestMain extends Entity implements Events {

/// Events

    @event function update();

/// Boot code

    static var _main:TestMain;

    public static function main():Void {

        _main = new TestMain();

    } //Main

/// Tests

    function new() {

        // Emit update event every 500ms
        function scheduleUpdate() {
            emitUpdate();
            Timer.delay(scheduleUpdate, 500);
        }
        scheduleUpdate();

        // Create a counter
        var counter = new SomeCounter();

        // Listen to update event and add ourself as owner
        onUpdate(this, function() {

            trace('UPDATE');

            // Increment counter, sometimes, sometimes not.
            if (Math.random() > 0.6) {
                trace('Increment counter');

                // Simply incrementing this variable should
                // trigger `countChange` event
                counter.count++;
            }

            // Call Autorun.tick() to flush invalidations (if any)
            Autorun.tick();

        });

        // Listen to update event and unbind automatically after the first call,
        // meaning the callback will be exactly run once.
        // (here we didn't provide any owner, which is fine, it is optional)
        onceUpdate(function() {

            trace('UPDATE (ONCE)');

        });

        // Run a callback to auto-bind with observable values and
        // re-run the callback everytime the observed values change.
        var autorun = new Autorun(function() {

            // Simply accessing `counter.count` will bind this
            // autorun callback with the observable `count` property.
            // Everytime `count` is modified, this callback will be re-run again.

            trace('  AUTORUN / Current count value: ' + counter.count);

        });

        // Destroy autorun after 15 seconds
        Timer.delay(function() {

            trace(' -- Destroy autorun (15s elapsed) -- ');
            
            autorun.destroy();
            autorun = null;

        }, 15000);

        // If you don't have an explicit update loop, you can use Autorun.autoTick()
        // with a specific interval, but this is not advised if you can call tick()
        // explicitly instead at every "frame update" of your app.
        //Autorun.autoTick(0.1);

        // Quit after 30 seconds
        Timer.delay(function() {

            Sys.exit(0);

        }, 30000);

    } //new

} //TestMain
