function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Toy Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'TOYARROW_Assets')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023')
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0')
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false)

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Toy Note' then
		doTweenColor('effect', 'boyfriend', 'FF7F00', 0.5, linear)
		--playSound('bloxy', 1.5)
		--setPropertyFromGroup ('playerStrums', i, 'alpha', 0)
		for i = 4,7 do
			noteTweenAlpha('note' .. i .. 'alphatween', i, 0, 0.2, 'linear')
		end
		runTimer('GhostDuration', 3)
		--triggerEvent('Change Scroll Speed', 1.5, 0.5)
	end
end

function onTimerCompleted(t, l, ll)
	if t == 'GhostDuration' then
		doTweenColor('diffect', 'boyfriend', 'FFFFFF', 0.5, linear)
		--triggerEvent('Change Scroll Speed', 1, 0.5)
		for i = 4,7 do
			noteTweenAlpha('note' .. i .. 'alphatween', i, 1, 0.5, 'linear')
		end
	end
end