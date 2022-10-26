--Max = 50 -- Amount of misses to Kill the Player


local font = "vcr.ttf";

function onCreate()
	
	addCharacterToList('bfITSNOTYOU', 'boyfriend')

	if songName == 'toykeeper' then
		addCharacterToList('toykeeper', 'dad')
	end

	if difficulty == 2 then
		Max = 35
	elseif difficulty == 0 then
		Max = 75
	elseif difficulty == 1 then
		Max = 50
	end

	luaDebugMode = true
	
	setProperty('cameraSpeed', 2.2);

	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Disabled');
end

function onCreatePost()
	if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		setProperty('scoreTxt.y', 32);
		setProperty('healthBar.y', 8);
	else if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
		setProperty('scoreTxt.y', 660);
		setProperty('healthBar.y', 700);
	end
	end
end

function onBeatHit()
	if songName == 'castoff' then
--Luego arreglo esto, Reminder
		if getProperty('curBeat') == 32 then
			setPropertyFromGroup('opponentStrums',0,'alpha',0)
			setPropertyFromGroup('opponentStrums',1,'alpha',0)
			setPropertyFromGroup('opponentStrums',2,'alpha',0)
			setPropertyFromGroup('opponentStrums',3,'alpha',0)

			setPropertyFromGroup('playerStrums',0,'alpha',0)
			setPropertyFromGroup('playerStrums',1,'alpha',0)
			setPropertyFromGroup('playerStrums',2,'alpha',0)
			setPropertyFromGroup('playerStrums',3,'alpha',0)

			
			
			elseif getProperty('curBeat') == 38 then
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)

			setPropertyFromGroup('opponentStrums',0,'alpha',1)
			setPropertyFromGroup('opponentStrums',1,'alpha',1)
			setPropertyFromGroup('opponentStrums',2,'alpha',1)
			setPropertyFromGroup('opponentStrums',3,'alpha',1)
		
		elseif getProperty('curBeat') == 232 then
			doTweenAlpha('hudAlpha', 'camHUD', 0, 0.2, 'quintOut');
	
		elseif getProperty('curBeat') == 238 then
			doTweenAlpha('hudAlpha', 'camHUD', 1, 0.9, 'quintOut');
			--acupuncture
		end
	end
end

function onStepHit()
	if songName == 'acupuncture' or songName == 'castoff' or songName == 'toykeeper' or songName == 'bad-end' then
		if curStep == 10 then
			modchart = false
		end
	end
	if songName == 'acupuncture' or songName == 'castoff' or songName == 'toykeeper' or songName == 'bad-end' then
		if curStep == 110 or curStep == 120 or curStep == 125 or curStep == 928 or curStep == 932 or curStep == 938 or curStep == 958 or curStep == 1172 or curStep == 1276 or curStep == 1282 or curStep == 1304 or curStep == 1536 or curStep == 1922 or curStep == 1937 or curStep == 1943 or curStep == 1956 then
			staticON()
		end
	end
	if songName == 'acupuncture' or songName == 'castoff' or songName == 'toykeeper' or songName == 'bad-end' then
		if curStep == 127 or curStep == 1024 or curStep == 1154 or curStep == 1176 or curStep == 1279 or curStep == 1300 or curStep == 1408 or curStep == 1792 or curStep == 1926 or curStep == 1940 or curStep == 1946 or curStep == 1960 then
			staticOFF()
		end
	end
	if curStep == 128 then
		if songName == 'toykeeper' then
			triggerEvent('Change Character', 1, 'toykeeper')
		end
	end
end

function staticON()
	setProperty('fx.alpha', 0.8)
	doTweenAlpha('staticON', 'fx', 0, 1, 'linear')
	playSound('stat', 0.3)
end

function staticOFF()
	setProperty('fx.alpha', 1)
	doTweenAlpha('staticON', 'fx', 0, 1, 'linear')
	playSound('stat', 0.3)
end

function staticBOP()
	setProperty('fx.alpha', 0.5)
	doTweenAlpha('staticON', 'fx', 0, 1, 'linear')
end

function onUpdate()
	if getProperty('songMisses') > 25 then
		cameraShake("hud", 0.002, 0.4);
	end
end