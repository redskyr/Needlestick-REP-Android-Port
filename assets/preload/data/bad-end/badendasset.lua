function onCreate()
    makeAnimatedLuaSprite('bfd', 'string', 550, 50)
	addAnimationByPrefix('bfd', 'stringstar', 'stringstar', 24, false)
	addAnimationByPrefix('bfd', 'stringA', 'stringA', 24, false)

    addAnimationByPrefix('bfd', 'stringout', 'stringout', 24, false)
    addAnimationByIndices('bfd','stringout','stringout','8,7,6,5,4,3,2,1',24);
    
    setProperty('camHUD.visible',false)
    addLuaSprite('bfd',true);
    setProperty('bfd.alpha', 0)

	addCharacterToList('bfstring', 'boyfriend')
    addCharacterToList('toykeepereye', 'dad')


    --OBJECT ORDER STUFF--


    setObjectOrder('bfd', '1');

    setObjectOrder('gf', '0');

  
    
    -- BLACK BAR STUFF  
    setProperty('blackbar1.alpha', 0)
    setProperty('blackbar2.alpha', 0)

end

function onBeatHit()
    if curBeat == 64 then --64
        setProperty('gf.visible', false)
        setProperty('hud.visible', false)
        setProperty('boyfriend.visible', false)
        setProperty('dad.visible', false)
        setProperty('bfd.alpha', 0)
    elseif curBeat == 55 then
        doTweenAlpha('bfd', 'bfd', 1, 2, 'quadInOut');
    elseif curBeat == 63 then
        objectPlayAnimation('bfd', 'stringA', true)
    elseif curBeat == 80 then -- FULL THING
        setProperty('gf.visible', false)
        setProperty('boyfriend.visible', true)
        setProperty('dad.visible', true)
        setProperty('camHUD.visible',true)
        setProperty('bfd.alpha', 1)    
        triggerEvent('Change Character', 0, 'bfstring')
        triggerEvent('Change Character', 1, 'toykeepereye')

        --POSITION AND X Y

        setProperty('bfd.x', 470)
        setProperty('bfd.y', 50)
        setProperty('dad.x', 550)
        setProperty('dad.y', 1)

        objectPlayAnimation('bfd', 'stringA', true)
    end
end