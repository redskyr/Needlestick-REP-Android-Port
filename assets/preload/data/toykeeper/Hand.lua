function onCreate()
	--makeAnimatedLuaSprite('hand','Tasset/Tor',0,470);
	makeAnimatedLuaSprite('hand', 'Tasset/hands', 100, 300)
	addAnimationByPrefix('hand', 'hand up', 'hand up', 24, false)
	addAnimationByPrefix('hand', 'hand down', 'hand down', 24, false)
	addAnimationByPrefix('hand', 'hand idle', 'hand idle', 24, true)
	addLuaSprite('hand',true);
	setObjectCamera('hand','camHUD');
	setProperty('hand.alpha',0)


	addCharacterToList('toykeeper', 'boyfriend')

	

	makeAnimatedLuaSprite('hand2', 'Tasset/handsr', 650, 370)
	addAnimationByPrefix('hand2', 'hand up r ', 'hand up r', 24, false)
	addAnimationByPrefix('hand2', 'hand down r', 'hand down r', 24, true)
	addAnimationByPrefix('hand2', 'hand idle r', 'hand idle r', 24, true)
	addLuaSprite('hand2',true);
	setObjectCamera('hand2','camHUD');
	setProperty('hand2.alpha',0)
	--setProperty('hand2.flip.x', true)

	--makeLuaSprite('hand3','Tasset/Tol',950,470);
	--addLuaSprite('hand3',true);
	--setObjectCamera('hand3','camGAME');
	--setProperty('hand3.alpha',1)

end

local angleshit = 5;
local anglevar = 5;

function onBeatHit()
	if curBeat == 64 then --64 
		HandApp()
	end
	if curBeat == 98 then 
		HandBye()
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

function HandApp()
	doTweenAlpha('turn', 'hand', 1, 0.3, 'circOut')
	doTweenAlpha('turn2', 'hand2', 1, 0.3, 'circOut')
	doTweenAlpha('gf', 'gf', 0, 5, 'circOut')
	objectPlayAnimation('hand', 'hand up')
	setProperty('hand2.x',600)
	objectPlayAnimation('hand2', 'hand up r')
	runTimer('handgrab', 0.2)
end

function HandBye()
	doTweenAlpha('turn', 'hand', 0, 0.5, 'circOut')
	doTweenAlpha('turn2', 'hand2', 0, 0.5, 'circOut')
	runTimer('resetpos', 1)
end

function handidle()
	objectPlayAnimation('hand', 'hand idle')
	
	objectPlayAnimation('hand2', 'hand idle r')
end

function resetpos()
	setProperty('hand.y',300)
	setProperty('hand2.x',600)
	
	setProperty('hand.angle',0)
	setProperty('hand.angle',0)
end

function onTimerCompleted(tag, l, ll)
	if tag  == 'handgrab' then
		objectPlayAnimation('hand', 'hand down')	
		objectPlayAnimation('hand2', 'hand down r')
		setProperty('hand2.x',850)
		setProperty('hand2.y',450)
		setProperty('hand.y',470)
		runTimer('handidle', 0.2)
	elseif tag == 'resetpos' then
		resetpos()
	elseif tag == 'handidle' then
		handidle()
		setProperty('hand.y',470)
		setProperty('hand.x',100)
		setProperty('hand2.x',900)
		setProperty('hand2.y',490)
		setProperty('hand.angle',-30)
		setProperty('hand2.angle',30)
	end
end
end