local campointx = 0
local campointy = 0
local bfturn = false
local camMovement = 10
local velocity = 1.5

	-- edit these 2 last values up here so you dont have to manually do every single one
	
function onMoveCamera(focus)
	if focus == 'boyfriend' then
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
	setProperty('defaultCamZoom',0.8)
	bfturn = true
	setProperty('cameraSpeed', 1)
	
	elseif focus == 'dad' then
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
	bfturn = false
	setProperty('cameraSpeed', 1)
	setProperty('defaultCamZoom',0.6)
		
	elseif focus == 'gf' then
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
	bfturn = true
	setProperty('cameraSpeed', 1)
	setProperty('defaultCamZoom',0.8)
	
	end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
	if bfturn then
		if direction == 0 then
			setProperty('camFollow.x', campointx - camMovement)
		elseif direction == 1 then
			setProperty('camFollow.y', campointy + camMovement)
		elseif direction == 2 then
			setProperty('camFollow.y', campointy - camMovement)
		elseif direction == 3 then
			setProperty('camFollow.x', campointx + camMovement)
		end
		setProperty('cameraSpeed', velocity)
	end	
end

		-- delete this if you dont want the oponent to move the camera
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not bfturn then
		if direction == 0 then
			setProperty('camFollow.x', campointx - camMovement)
		elseif direction == 1 then
			setProperty('camFollow.y', campointy + camMovement)
		elseif direction == 2 then
			setProperty('camFollow.y', campointy - camMovement)
		elseif direction == 3 then
			setProperty('camFollow.x', campointx + camMovement)
		end
		setProperty('cameraSpeed', velocity)
	end	
end

	-- cringe camera EWW --