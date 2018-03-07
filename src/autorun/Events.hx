package autorun;

/** Events allows to add strictly typed events to classes.
    Generates related methods: on|once|off|emit{EventName}() */
#if !macro
@:autoBuild(autorun.macros.EventsMacro.build())
#end
interface Events {}
