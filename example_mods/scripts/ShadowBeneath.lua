--Max = 50 -- Amount of misses to Kill the Player


local font = "vcr.ttf";

function onCreate()
    makeLuaSprite('shadow', 'shadow', 645, 685);
	setProperty('shadow.alpha', 0.4);
	--setObjectCamera('shadow', 'hud')
	addLuaSprite('shadow', true);
	scaleObject('shadow', 0.75, 1)

	setObjectOrder('shadow', 2)

	makeLuaSprite('shadow2', 'shadow', 985, 805);
	setProperty('shadow2.alpha', 0.3);
	--setObjectCamera('shadow', 'hud')
	addLuaSprite('shadow2', true);
	scaleObject('shadow2', 1, 1)

	setObjectOrder('shadow2', 2)


	makeLuaSprite('shadow3', 'shadow', 155, 805);
	setProperty('shadow3.alpha', 0.3);
	--setObjectCamera('shadow', 'hud')
	addLuaSprite('shadow3', true);
	scaleObject('shadow3', 1, 1)

	setObjectOrder('shadow3', 2)

	setProperty('defaultCamZoom',0.8)

end
