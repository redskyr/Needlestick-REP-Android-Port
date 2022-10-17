function onCreate()
    setProperty('camHUD.visible',false)

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

        --POSITION AND X Y

        setProperty('bfd.x', 470)
        setProperty('bfd.y', 50)
        setProperty('dad.x', 550)
        setProperty('dad.y', 1)

        objectPlayAnimation('bfd', 'stringA', true)
    end
end