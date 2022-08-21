local angleshit = 1;
local anglevar = 1;

function onBeatHit()
	if curBeat > 64 and curBeat < 96 or curBeat > 160 and curBeat < 288 or curBeat > 387 then 
		triggerEvent('Add Camera Zoom', 0.02,0.03)

		if curBeat % 4 == 0 then
			angleshit = anglevar;
		else
			angleshit = -anglevar;
		end
		setProperty('camHUD.angle',angleshit*3)
		setProperty('camGame.angle',angleshit*3)
		doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
		doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
		doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
		doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	else
		setProperty('camHUD.angle',0)
		setProperty('camHUD.x',0)
		setProperty('camHUD.x',0)
	if curBeat > 96  and curBeat < 159  then 
		setProperty('camHUD.angle',angleshit*2)
		setProperty('camGame.angle',angleshit*2)
		---doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.003, 'circOut')
		--doTweenX('tuin', 'camHUD', -angleshit*9, crochet*0.002, 'linear')
		--doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.003, 'circOut')
		--doTweenX('ttrn', 'camGame', -angleshit*9, crochet*0.002, 'linear')
	end
end

end
		

