local barAmount = 238
local burst = false
local soundPlayed = false
local soundPlayVar = false

local redbar = false

function onCreate()
	--precacheImage('mechanics/temper')
	--precacheImage('mechanics/temperlines')
	precacheImage('vignettes/blackvignette')

	-- bar bg or smthng
    characterPlayAnim('gf', 'intro', true);
	
	makeLuaSprite('barBlue', 'barBlue', 1231, 430)
	makeGraphic('barBlue', 18, 1, 'FFFFFF')
	setProperty('barBlue.color', getColorFromHex('15E9FF'))
	setObjectCamera('barBlue', 'hud')
	setProperty('barBlue.origin.y', 1)
	addLuaSprite('barBlue')
	setProperty('barBlue.scale.y', shielded)

	makeLuaSprite('BFreeze', 'Cold/BigFreeze', 0, 0);
	setProperty('BFreeze.alpha', 0.1);
	setObjectCamera('BFreeze', 'other')
	addLuaSprite('BFreeze', true);
end


function Freeze()
	setProperty('boyfriend.stunned', true)
	runTimer('Freezer', 3);
	characterPlayAnim('bf', 'singDOWNmiss', true);
	setProperty('BFreeze.alpha', 0.5);
	colvulnerable = false 
	playSound('freeze', 0.2)
	doTweenColor('effect', 'boyfriend', '00B7FF', 0.5, linear)

end

function BigFreeze()
	setProperty('boyfriend.stunned', true)
	runTimer('Bigf', 5);
	characterPlayAnim('bf', 'singDOWNmiss', true);
	setProperty('BFreeze.alpha', 0.7);
	colvulnerable = false 
	playSound('freeze', 0.1)
	doTweenColor('effect', 'boyfriend', '00B7FF', 0.5, linear)


end
	
colvulnerable = true

function onUpdate(elapsed)
		local cold = math.random(1, 1000)
		if barAmount <= 65 then
			if colvulnerable == true then
				if cold == 52 then
				BigFreeze()
				debugPrint'Te re contra congelaste'
				end
			end
		end
	if curBeat >= 1 then
		if redbar == true then
			setProperty('barBlue.color', getColorFromHex('ff0400'))
		elseif redbar == false then
			setProperty('barBlue.color', getColorFromHex('15E9FF'))
		end
		if barAmount <= 65 then
			redbar = true;
		end
		if barAmount >= 65 and barAmount <= 222 then
			redbar = false;
		end
		if barAmount<0 then
			setProperty('barBlue.alpha', 1)
		end
		if burst == false then
			    if barAmount ~= 0 then
  	 	     	barAmount= barAmount - (elapsed * 9)
				setProperty('barBlue.scale.y', barAmount)
				elseif barAmount ~= 0 and curBeat >= 320 then
  	 	     	barAmount= barAmount - (elapsed * 11)
				setProperty('barBlue.scale.y', barAmount)
			end		
		end
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.E') and E == true then -- bar shit
		barAmount= barAmount + 40
		runTimer('CooldownE', 0.01);
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Q') and Q == true  then
		barAmount= barAmount - 80
		runTimer('CooldownQ', 0.01);
    end
end



function onTimerCompleted(tag, l, ll)
    if tag == 'Bigf' then
		setProperty('boyfriend.stunned', false)
		setProperty('BFreeze.alpha', 0.1);
		doTweenColor('diffect', 'boyfriend', 'FFFFFF', 0.5, linear)

		colvulnerable = true; 


	elseif tag == 'Freezer' then
		setProperty('boyfriend.stunned', false)
		doTweenColor('diffect', 'boyfriend', 'FFFFFF', 0.5, linear)
		setProperty('BFreeze.alpha', 0.1);
		runTimer('CooldownOffQ', 3);
		colvulnerable = true; 
	elseif tag == 'CooldownOffQ' then
		Q = true
		--debugPrint("You can press again")
    end
end
  

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
			if burst == false then
			barAmount= barAmount + 8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
			setProperty('barBlue.scale.y', barAmount)
			end	
			if barAmount > 275 and burst == false then
				barAmount=275
			end
	end
end

function noteMiss()
	if not isSustainNote then
		if burst == false then
		barAmount= barAmount - 15
		setProperty('barBlue.scale.y', barAmount)
		end	
		if barAmount > 275 and burst == false then
			barAmount=275
		end
	end
end