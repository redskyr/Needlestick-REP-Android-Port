local active = false
local utilUnactive = nil
local alphaChange = nil

function onEvent(name, value1, value2)
	if name == 'curse of the darkness' then
	    active = true --this activates the thing
	    utilUnactive = curStep + value1 --curStep + value1 = ending step
		
		alphaChange = value2 --self explanatory
    end
end

function onUpdate(elapsed)
    if active == true then
	    local curseAlpha = getProperty('curse.alpha')--gets the alpha
		setProperty('curse.alpha', curseAlpha - alphaChange)--changes the alpha of the graphic
	    if curseAlpha <= 0 then
		    setProperty('curse.alpha', 1.1)--makes the sprite visible if the alpha <= to 0
		end
	    if curStep == utilUnactive then
		    active = false --this desactivates the thing when curStep == ending step
			setProperty('curse.alpha', 0)
		end
	end
end
