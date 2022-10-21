--Max = 50 -- Amount of misses to Kill the Player


local allowCountdown = false

function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        setProperty('inCutscene', true);
        startVideo('NE') -- make sure it's in the videos folder
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end