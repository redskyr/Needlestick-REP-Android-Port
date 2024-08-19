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
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import lime.app.Application;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;
using flixel.util.FlxSpriteUtil;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String>;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var bgneedle:FlxObject;
	var hitneedle:FlxObject;

	var bopcount:Int = 0;

	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var LMAOO:FlxBackdrop;
	var LMAOO2:FlxBackdrop;
	var sky:FlxBackdrop;

	override function create()
	{
		if(ClientPrefs.freeplayUnlocked){
			optionShit = [
				'story_mode',
				'freeplay',
				'credits',
				'options'
			];
		} else {
			optionShit = [
				'story_mode',
				'credits',
				'options'
			];
		}
		
		//i now know why those two that i just deleted weren't used more

		WeekData.loadTheFirstEnabledMod();
		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = false;
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		LMAOO = new FlxBackdrop(Paths.image('sonic'), 0.2, 0, true, true);
		LMAOO.velocity.set(100, 0);
		LMAOO.updateHitbox();
		LMAOO.alpha = 1;
		LMAOO.screenCenter(X);

		LMAOO2 = new FlxBackdrop(Paths.image('Chess'), 0.2, 0, true, true);
		LMAOO2.velocity.set(80, 50);
		LMAOO2.updateHitbox();
		LMAOO2.alpha = 1;
		LMAOO2.screenCenter(X);
		
		sky = new FlxBackdrop(Paths.image("ghost/mainSky"), 0.2, 0, true, true);
		sky.velocity.set(0, 90);
		sky.scale.set(3, 7);
		sky.updateHitbox();
		sky.alpha = 1;

		sky.y = -100;
		sky.antialiasing = false;


		var yScroll:Float = 0.00;
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('sonic'));
		bg.scrollFactor.set(0, yScroll);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		//add(bg);
		add(LMAOO2);

		add(LMAOO);


	//	/var bgneedle:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('needlebg'));

		bgneedle = new FlxSprite(605, 50).loadGraphic(Paths.image('needlebg')); 
		
		hitneedle = new FlxSprite(900, 400).loadGraphic(Paths.image('hitne')); 
		hitneedle.scrollFactor.set(0, 0);
		add(hitneedle);

		// hitne
		bgneedle.scrollFactor.set(0, 0);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		//bgneedle.updateHitbox();
		bgneedle.screenCenter(X);
		add(bgneedle);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		if(ClientPrefs.menufilter)
			add(sky);


		magenta = new FlxSprite(-80).loadGraphic(Paths.image('sonic'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		//add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if android
		addVirtualPad(UP_DOWN, A_B);
		#end	

			super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{

		if (bopcount == 5)
		{
			FlxTween.tween(bgneedle, {alpha: 0}, 0.4);
			FlxTween.tween(hitneedle, {alpha: 0}, 0.001);
			hitneedle.x = 10020; //Yeah.
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		
		if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(hitneedle))
			{
				FlxG.sound.play(Paths.sound('bop'));
				bopcount ++;
				trace(":: " + bopcount);
			}
		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.mouse.visible = false;
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys) && ClientPrefs.freeplayUnlocked)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
			{
				spr.screenCenter(X);
				var singleItem:Int = spr.ID;
	
				switch(singleItem){
					case 0:  spr.x -= 396; //storuy, esto va pa aca -ñ
					case 1:  spr.x -= 430; //free play, esto va pa aca -ñ
					case 2:  spr.x -= 430; //options, esto va pa aca -ñ
					case 3:  spr.x -= 430; //creddits, esto va pa aca -ñ
					case 4:  spr.x -= 430; //creddits, esto va pa aca -ñ
					default: spr.x -= 5;
				};
	
				//spr.x -= 400;
				//- izquierda, + derecha
			});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
