package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

using StringTools;
using flixel.util.FlxSpriteUtil;

class WarningState extends MusicBeatState {
    var selection:String;
    var infoText:FlxText;
    var selectionText:FlxText;
    var curSelected:Bool;
    var cooldown:Bool = false;

    override function create() {
        if(ClientPrefs.menufilter){
            curSelected = true;
            selection = 'YES';
        } else {
            curSelected = false;
            selection = 'NO';
        }

		infoText = new FlxText(0, 100, FlxG.width,
			"WARNING\n"
			+ "THIS MOD HAS SOME TRIPPY FILTERS THAT MIGHT BE SENSITIVE TO SOME PEOPLE"
			+ "\nPRESS ENTER TO TOGGLE ON OR OFF THE FILTERS"
            + "\nPRESS SPACE TO CONTINUE",
			32);
        infoText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        infoText.alpha = 1;
        infoText.screenCenter(X);
        add(infoText);

        selectionText = new FlxText(0, 400, FlxG.width, "FILTERS ON: " + selection, 32);
        selectionText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		selectionText.screenCenter(X);
		add(selectionText);
        super.create();
    }

	override function update(elapsed:Float) {
        if(FlxG.keys.justPressed.ENTER && !cooldown){
            if(!curSelected) {
                trace("yeah");
                ClientPrefs.menufilter = true;
                cooldown = true;
                curSelected = true;
                selectionText.text = "FILTERS ON: YES";
            } else if (curSelected) {
                trace("nope");
                ClientPrefs.menufilter = false;
                cooldown = true;
                curSelected = false;
                selectionText.text = "FILTERS ON: NO";
            }
            FlxG.save.data.menufilter = ClientPrefs.menufilter;
            new FlxTimer().start(0.3, function(tmr:FlxTimer) {
                cooldown = false;
            });
        }
        if(FlxG.keys.justPressed.SPACE){
            ClientPrefs.showWarningScreen = false;

            var warningSave:FlxSave = new FlxSave();
            warningSave.bind('warningscreen', 'ninjamuffin99');
            warningSave.data.isTrue = ClientPrefs.showWarningScreen;
            warningSave.flush();
            FlxG.log.add('warning setting saved!');

            new FlxTimer().start(0.1, function(spacetmr:FlxTimer) {
                #if debug
                trace("if you get an error while using debug mode about frame errors, ignore them those are for the story mode effect");
                #end
                MusicBeatState.switchState(new MainMenuState());
            });
        }
        super.update(elapsed);
    }
}