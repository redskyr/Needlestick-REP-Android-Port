package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.typeLimit.OneOfTwo;

class TwnSprite extends FlxText     // uhhhhhhh sure ig lol if it works 
{
    private var twn:FlxTween = null;
    private var stwn:FlxTween = null;
    private var ctwn:FlxTween = null;

    public var onFinish:(FlxTween) -> Void = null;
    public var onCancel:(FlxTween) -> Void = null;
    public var onFinishScale:(FlxTween) -> Void = null;
    public var onCancelScale:(FlxTween) -> Void = null;
    public var onFinishColor:(FlxTween) -> Void = null;
    public var onCancelColor:(FlxTween) -> Void = null;

    public function new(_x:Float = 0, _y:Float = 0, ?texture:Dynamic) {
        super(_x, _y);

        if (Std.isOfType(texture, String)) {
            loadGraphic(texture);
        } else if (Std.isOfType(texture, Array)) {
            var w = 1;
            var h = 1;
            var c = 0xff000000;
            if (texture.length >= 1)
                w = texture[0];
            if (texture.length >= 2)
                h = texture[1];
            if (texture.length >= 3)
                c = texture[2];

            makeGraphic(w, h, c);
        }

        antialiasing = ClientPrefs.globalAntialiasing;
    }

    /**
      * @param type     "n" = normal tweens, "s" = scale tween; "c" = color tween 
      * @param time     time in seconds 
      * @param prm     parameters (use Int if you're tweening colors) e.g: {x: 20, y: 10} 
      * @param return   returns the tween 
    **/
    public function tween(type:String = "n", time:Float = 1, ?prm:Dynamic, ?easeValue:Dynamic):Void {
        if (easeValue == null)
            easeValue = FlxEase.quadInOut;

        cancelTween(type);

        if (type == "n") {
            var obj:Dynamic = this;
            twn = FlxTween.tween(obj, prm, time, {ease: easeValue,
                onComplete: function(tn:FlxTween) {
                    if (onFinish != null)
                        onFinish(tn);
                    onCancel = null;
                    onFinish = null;
                    ctwn = null;
                }
            });
            return;
        } else if (type == "s") {
            var obj:Dynamic = scale;
            stwn = FlxTween.tween(obj, prm, time, {ease: easeValue,
                onComplete: function(tn:FlxTween) {
                    if (onFinish != null)
                        onFinish(tn);
                    onCancelScale = null;
                    onFinishScale = null;
                    stwn = null;
                }
            });
            return;
        } else if (type == "c") {
            ctwn = FlxTween.color(this, time, this.color, Std.int(prm), {ease: easeValue,
                onComplete: function(tn:FlxTween) {
                    if (onFinishColor != null)
                        onFinishColor(tn);
                    onCancelColor = null;
                    onFinishColor = null;
                    ctwn = null;
                }
            });
            return;
        }
        return;
    }

    public function cancelTween(type:String = "n", runFunction:Bool = true) {
        switch (type) {
            case "n":
                if (twn != null) {
                    onFinish = null;
                    if (onCancel != null && runFunction)
                        onCancel(twn);
                    onCancel = null;
                    twn.cancel();
                }
            case "s":
                if (stwn != null) {
                    onFinishScale = null;
                    if (onCancelScale != null && runFunction)
                        onCancelScale(stwn);
                    onCancelScale = null;
                    stwn.cancel();
                }
            case "c":
                if (ctwn != null) {
                    onFinish = null;
                    if (onCancel != null && runFunction)
                        onCancel(ctwn);
                    onCancel = null;
                    ctwn.cancel();
                }
        }
    }
}