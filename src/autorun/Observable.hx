package autorun;

/** Observable allows to observe properties of an object. */
#if !macro
@:autoBuild(autorun.macros.ObservableMacro.build())
#end
interface Observable {}
