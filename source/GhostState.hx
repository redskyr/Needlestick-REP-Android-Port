package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.effects.chainable.FlxShakeEffect;
import flixel.addons.display.FlxBackdrop;
import flash.system.System;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class GhostState extends MusicBeatState
{
	var icontext:FlxText;
	var icontext2:FlxText;

	var ytext:FlxText;
	var noootext:FlxText;

    var crosshair:FlxSprite;

	var sky:FlxBackdrop;
    var titlestatebg:FlxBackdrop;

	var offsetThing:Float = -75;
    var random:Float = 0;

	override function create()
	{
		crosshair = new FlxSprite(Paths.image('ghost/cursor'));

		FlxG.mouse.load(crosshair.pixels);

		FlxG.mouse.visible = true;

		random = FlxG.random.float(1, 10);

		titlestatebg = new FlxBackdrop(Paths.image('ghost/credbg'), 0.2, 0, true, true);
		titlestatebg.velocity.set(200, 110);
		titlestatebg.updateHitbox();
		titlestatebg.alpha = 0.15;
		titlestatebg.screenCenter(X);
		add(titlestatebg);

		ytext = new FlxText(400, 66, 200, "Yes.", 32);
		ytext.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER /*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		ytext.scrollFactor.set();
		ytext.screenCenter(Y);
		add(ytext);

		noootext = new FlxText(700, 665, 200, "No.", 32);
		noootext.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER /*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		noootext.scrollFactor.set();
		noootext.screenCenter(Y);
		add(noootext);

		icontext = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "Do you believe in Ghosts?", 32);
		icontext.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER /*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		icontext.scrollFactor.set();
		add(icontext);

		icontext2 = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "Then you have nothing to do here.", 32);
		icontext2.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER /*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		icontext2.scrollFactor.set();
		add(icontext2);

		icontext2.visible = false;

		if(ClientPrefs.menufilter){
			sky = new FlxBackdrop(Paths.image("ghost/mainSky"), 0.2, 0, true, true);
			sky.velocity.set(0, 90);
			sky.scale.set(2, 7);
			sky.updateHitbox();
			sky.screenCenter();
			sky.y = -100;
			sky.antialiasing = false;
			add(sky);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(ytext) && FlxG.mouse.justPressed) {
			trace("yes");
			PlayState.SONG = Song.loadFromJson('bad-end', 'bad-end');
            LoadingState.loadAndSwitchState(new PlayState());
			FlxG.mouse.unload();
			FlxG.mouse.useSystemCursor = false;
			FlxG.mouse.visible = false;
		} else if (FlxG.mouse.overlaps(noootext) && FlxG.mouse.justPressed) {
			var timer:FlxTimer = new FlxTimer().start(random, sayHello);
			trace("no");
			FlxG.sound.playMusic(Paths.music('ghost'), 1, true);
			icontext2.visible = true;
			icontext.visible = false;
			FlxG.camera.shake(1, 1);
		}

		if (FlxG.mouse.overlaps(noootext)) {
			FlxG.camera.shake(0.005, 0.005);
			FlxTween.tween(noootext.scale, {x: 1.15, y: 1.15}, 0.35, {ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT});
		} else if (FlxG.mouse.overlaps(ytext)) {
			FlxTween.tween(ytext.scale, {x: 1.15, y: 1.15}, 0.35, {ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT});
		} 

		if(!FlxG.mouse.overlaps(noootext)) {
			FlxTween.tween(noootext.scale, {x: 1, y: 1}, 0.55, {ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT});
		} else if(!FlxG.mouse.overlaps(ytext)) {
			FlxTween.tween(ytext.scale, {x: 1, y: 1}, 0.55, {ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT});
		}

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.music('bad'), 1, true);
		}
	}

	private function sayHello(timer:FlxTimer)
	{
		System.exit(0);
		System.exit(0);
	}
}