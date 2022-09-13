--Max = 50 -- Amount of misses to Kill the Player


local font = "vcr.ttf";

function onCreate()
	
	addCharacterToList('bfITSNOTYOU', 'boyfriend')

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
	makeLuaText('info', 'Dont Get ' .. (Max) .. (" Misses..") , 750, -35);
    setTextBorder('info', 2, '000000');
    setTextAlignment('info', 'right');
    setTextFont('info', font);
    setTextSize('info', 30.35);
	setTextColor('info', '999999')
	addLuaText('info')
	setProperty('info.alpha', 1);
	setProperty('info.y', 400);
	doTweenAlpha('info', 'info', 0, 15, 'quintOut');

	setProperty('scoreTxt.y', 12);
	if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		setProperty('scoreTxt.y', 32);
		setProperty('healthBar.y', 8);
		else if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
			setProperty('scoreTxt.y', 660);
			setProperty('healthBar.y', 700);
		end
	end
end

--[[function onBeatHit()
	if curBeat == 1 then
		doTweenAlpha('info', 'info', 1, 0.8, 'quintOut');
	elseif curBeat == 10 then
		doTweenAlpha('info', 'info', 0.001, 2, 'quintOut');
	function onSongStart()
		if songName == 'acupuncture' then
	if getProperty('songMisses') > 0 then
		loadSong('toykeeper', 2)
	end
	function onSongEnd()
		if isStoryMode then		
			if songName == 'acupuncture' then
				if getProperty('songMisses') > 30 then
			
					loadSong('bad-end', 2);
					return Function_Stop;
				end
		end 
		return Function_Continue;
		end
	end]]
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
		if songName == 'acupuncture' and isStoryMode then
	---		if isStoryMode then		
			if getProperty('curBeat') == 300 then
				if getProperty('songMisses') > 30 then
					loadSong('bad-end', 2);
				end
			end
		end
	end
function noteMiss()
	if getProperty('songMisses') == Max then
		setProperty('health', getProperty('health')-200);
	elseif getProperty('songMisses') == 10 then
		setProperty('fx2.alpha', 0.2)
	elseif getProperty('songMisses') == 15 then
		setProperty('fx2.alpha', 0.3)
	elseif getProperty('songMisses') == 20 then
		setProperty('fx2.alpha', 0.4)	
	elseif getProperty('songMisses') == 40 then
		setProperty('fx2.alpha', 0.4)
	elseif getProperty('songMisses') == 45 then
		setProperty('fx2.alpha', 0.5)
	elseif getProperty('songMisses')  > 0 then
		staticBOP()
	end
end

function onStepHit()
	if curStep == 10 then
		modchart = false
	end
	if curStep == 110 or curStep == 120 or curStep == 125 or curStep == 928 or curStep == 932 or curStep == 938 or curStep == 958 or curStep == 1172 or curStep == 1276 or curStep == 1282 or curStep == 1304 or curStep == 1536 or curStep == 1922 or curStep == 1937 or curStep == 1943 or curStep == 1956 then
		staticON()
	end
	if curStep == 127 or curStep == 1024 or curStep == 1154 or curStep == 1176 or curStep == 1279 or curStep == 1300 or curStep == 1408 or curStep == 1792 or curStep == 1926 or curStep == 1940 or curStep == 1946 or curStep == 1960 then
		staticOFF()
	end
	if curStep == 128 then
		if songName == 'Toykeeper' then
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

function onGameOver()
	if  getProperty('songMisses') == Max then
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'Toykeeper'); --put in mods/music/
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'Laugh');
			setPropertyFromClass('GameOverSubstate', 'characterName', 'bfITSNOTYOU'); --Character json file for the death animation
			setProperty('fx.alpha', 0.8)
    end
end

function onNoteMiss()
	if getProperty('songMisses') > 0 then
		setProperty('health', getProperty('health')-200);
	end
end