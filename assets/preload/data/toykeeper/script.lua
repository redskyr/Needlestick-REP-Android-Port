local angleshit = 1;
local anglevar = 1;

function onCreate()
	--[[makeAnimatedLuaSprite('hand', 'Tasset/hands', 100, 300)
	addAnimationByPrefix('hand', 'hand up', 'hand up', 24, false)
	addAnimationByPrefix('hand', 'hand down', 'hand down', 24, false)
	addAnimationByPrefix('hand', 'hand idle', 'hand idle', 24, true)
	addLuaSprite('hand',true);
	setObjectCamera('hand','camHUD');
	setProperty('hand.alpha',0)]]

	--addCharacterToList('toykeeper', 'boyfriend')

	--[[makeAnimatedLuaSprite('handR', 'Tasset/handsr', 650, 370)
	addAnimationByPrefix('handR', 'hand up r ', 'hand up r', 24, false)
	addAnimationByPrefix('handR', 'hand down r', 'hand down r', 24, true)
	addAnimationByPrefix('handR', 'hand idle r', 'hand idle r', 24, true)
	addLuaSprite('handR',true);
	setObjectCamera('handR','camHUD');
	setProperty('handR.alpha',0)]]
	--setProperty('handR.flip.x', true)

	--makeLuaSprite('hand3','Tasset/Tol',950,470);
	--addLuaSprite('hand3',true);
	--setObjectCamera('hand3','camGAME');
	--setProperty('hand3.alpha',1)

end

function onBeatHit()
	if  curBeat > 160 and curBeat < 288 or curBeat > 390 then 
		triggerEvent('Add Camera Zoom', 0.01,0.02)

		if curBeat % 4 == 0 then
			angleshit = anglevar;
		else
			angleshit = -anglevar;
		end
		if curBeat % 2 == 0 then

			setProperty('camHUD.angle',angleshit*3)
			setProperty('camGame.angle',angleshit*3)
			doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
			doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
			doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
			doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
		end
	end
	if curBeat == 160 then
		HandApp()
	end
	if curBeat == 288 then
		HandBye()
	if curBeat == 388 then
		HandApp()
	end
end

end
		

function HandApp()
	doTweenAlpha('turn', 'handL', 1, 0.3, 'circOut')
	doTweenAlpha('turn2', 'handR', 1, 0.3, 'circOut')
	objectPlayAnimation('handL', 'hand up')
	setProperty('handR.x',600)
	objectPlayAnimation('handR', 'hand up')
	runTimer('handgrab', 0.2)
end

function HandBye()
	doTweenAlpha('turn', 'handL', 0, 0.5, 'circOut')
	doTweenAlpha('turn2', 'handR', 0, 0.5, 'circOut')
	runTimer('resetpos', 1)
end

function handidle()
	objectPlayAnimation('handL', 'hand idle')
	
	objectPlayAnimation('handR', 'hand idle')
end

function resetpos()
	setProperty('handL.y',300)
	setProperty('handR.x',600)
	
	setProperty('handL.angle',0)
	setProperty('handL.angle',0)
end

function onTimerCompleted(tag, l, ll)
	if tag  == 'handgrab' then
		objectPlayAnimation('handL', 'hand down')	
		objectPlayAnimation('handR', 'hand down')
		setProperty('handR.x',850)
		setProperty('handR.y',450)
		setProperty('handL.y',470)
		runTimer('handidle', 0.2)
	elseif tag == 'resetpos' then
		resetpos()
	elseif tag == 'handidle' then
		handidle()
		setProperty('handL.y',470)
		setProperty('handL.x',100)
		setProperty('handR.x',900)
		setProperty('handR.y',490)
		setProperty('handL.angle',-30)
		setProperty('handR.angle',30)
	end
end
