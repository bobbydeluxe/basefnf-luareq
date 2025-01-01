-- Variable initialization
local o, p, c, t, y, i, v, b, n, m, u, q = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

-- Helper function to mute/unmute sounds
function toggleSoundMute(isMuted, soundType)
    if soundType == 'music' then
        setPropertyFromClass('flixel.FlxG', 'sound.music.volume', isMuted and 0 or 1)
    end
end

-- Function to toggle opponent strums visibility
function toggleOpponentStrums()
    local newAlpha = (o == 1) and 0 or 1
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'alpha', newAlpha)
    end
    o = (o == 1) and 0 or 1
    debugPrint((o == 1) and "Opponent Notes On" or "Opponent Notes Off")
end

-- Function to toggle player strums visibility
function togglePlayerStrums()
    local newAlpha = (p == 1) and 0 or 1
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'alpha', newAlpha)
    end
    p = (p == 1) and 0 or 1
    debugPrint((p == 1) and "Player Notes On" or "Player Notes Off")
end

-- Function to toggle HUD visibility
function toggleHUD()
    local targetAlpha = (c == 1) and 0 or 1
    doTweenAlpha('GUItween', 'camHUD', targetAlpha, 0.2, 'linear')
    c = (c == 1) and 0 or 1
    debugPrint((c == 1) and "HUD Off" or "HUD On")
end

-- Function to toggle health drain and gain functionality
function toggleHealthDrain()
    if t == 1 then
        function opponentNoteHit()
            local health = getProperty('health')
            if health > 0.4 then
                setProperty('health', health + 0.02)
                if health > 1 then
                    setProperty('health', health + 0.03)
                end
            end
        end
        debugPrint("Health Drain Off")
    elseif t == 2 then
        function opponentNoteHit() 
            -- Do nothing for health drain off
        end
        debugPrint("Health Drain On")
    end
    t = (t == 1) and 2 or 1
end

-- Function to toggle health gain functionality
function toggleHealthGain()
    if y == 1 then
        function goodNoteHit()
            setProperty('health', getProperty('health') - 0.04)
        end
        debugPrint("Health Gain Off")
    elseif y == 2 then
        function goodNoteHit()
            -- Do nothing for health gain off
        end
        debugPrint("Health Gain On")
    end
    y = (y == 1) and 2 or 1
end

-- Function to mute/unmute instrumental and vocals
function toggleInstrumentalMute()
    i = (i == 1) and 0 or 1
    toggleSoundMute(i == 1, 'music')
    debugPrint((i == 1) and "Inst Muted" or "Inst Unmuted")
end

function toggleVoicesMute()
    v = v + 1

    if v == 1 then
        debugPrint("Voices Muted")
        setProperty('vocals.volume', 0)
        setProperty('opponentVocals.volume', 0)
        
        function goodNoteHit(id, direction, noteType, isSustainNote, character, animId, forced)
            setProperty('vocals.volume', 0)
        end
        
        function opponentNoteHit(id, direction, noteType, isSustainNote, character, animId, forced)
            setProperty('opponentVocals.volume', 0)
        end
    end
    
    if v == 2 then
        debugPrint("Voices Unmuted")
        setProperty('vocals.volume', 1)
        setProperty('opponentVocals.volume', 1)
        v = 0
        
        function goodNoteHit(id, direction, noteType, isSustainNote, character, animId, forced)
            setProperty('vocals.volume', 1)
        end
        
        function opponentNoteHit(id, direction, noteType, isSustainNote, character, animId, forced)
            setProperty('opponentVocals.volume', 1)
        end
    end
end


-- Function to toggle bot play and practice mode
function toggleBotPlay()
    b = (b == 1) and 0 or 1
    setProperty('cpuControlled', b == 1)
    setProperty('botplayTxt.visible', b == 1)
    debugPrint((b == 1) and "BotPlay On" or "BotPlay Off")
end

function togglePracticeMode()
    n = (n == 1) and 0 or 1
    setProperty('practiceMode', n == 1)
    setProperty('practiceModeTxt.visible', n == 1)
    debugPrint((n == 1) and "PracticeMode On" or "PracticeMode Off")
end

-- Function to reset debug commands
function resetDebugCommands()
    debugPrint("Debug Commands Reset")
    -- Reset all toggles
    o, p, c, t, y, i, v, b, n, m, u, q = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    setPropertyFromGroup('opponentStrums', 0, 'alpha', 1)
    setPropertyFromGroup('playerStrums', 0, 'alpha', 1)
    doTweenAlpha('GUItween', 'camHUD', 1, 0.2, 'linear')
    -- Reset health draining/gaining effects and other toggles
    opponentNoteHit = function() end
    goodNoteHit = function() end
end

-- Scroll Mode Functions
function toggleMiddleScroll()
    if m == 1 then
        noteTweenAlpha('note movement1', 0, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 0, 0.1, 'cubeInOut')
        noteTweenX('note movement5', 4, 412, 0.1, 'cubeInOut')
        noteTweenX('note movement6', 5, 524, 0.1, 'cubeInOut')
        noteTweenX('note movement7', 6, 636, 0.1, 'cubeInOut')
        noteTweenX('note movement8', 7, 748, 0.1, 'cubeInOut')
        debugPrint("Middlescroll On")
    else
        noteTweenAlpha('note movement1', 0, 1, 0.01, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 1, 0.01, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 1, 0.01, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 1, 0.01, 'cubeInOut')
        noteTweenX('note movement5', 4, 732, 0.01, 'cubeInOut')
        noteTweenX('note movement6', 5, 844, 0.01, 'cubeInOut')
        noteTweenX('note movement7', 6, 956, 0.01, 'cubeInOut')
        noteTweenX('note movement8', 7, 1068, 0.01, 'cubeInOut')
        debugPrint("Middlescroll Off")
    end
    m = (m == 1) and 0 or 1
end

function toggleSpreadScroll()
    if u == 1 then
        noteTweenAlpha('note movement1', 0, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 0, 0.1, 'cubeInOut')
        noteTweenX('note movement5', 4, 76, 0.1, 'cubeInOut')
        noteTweenX('note movement6', 5, 412, 0.1, 'cubeInOut')
        noteTweenX('note movement7', 6, 748, 0.1, 'cubeInOut')
        noteTweenX('note movement8', 7, 1084, 0.1, 'cubeInOut')
        debugPrint("Spreadscroll On")
    else
        noteTweenAlpha('note movement1', 0, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 1, 0.1, 'cubeInOut')
        noteTweenX('note movement5', 4, 732, 0.1, 'cubeInOut')
        noteTweenX('note movement6', 5, 844, 0.1, 'cubeInOut')
        noteTweenX('note movement7', 6, 956, 0.1, 'cubeInOut')
        noteTweenX('note movement8', 7, 1068, 0.1, 'cubeInOut')
        debugPrint("Spreadscroll Off")
    end
    u = (u == 1) and 0 or 1
end

function toggleTightScroll()
    if q == 1 then
        noteTweenAlpha('note movement1', 0, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 0, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 0, 0.1, 'cubeInOut')
        noteTweenX('note movement5', 4, 500, 0.1, 'cubeInOut')
        noteTweenX('note movement6', 5, 545, 0.1, 'cubeInOut')
        noteTweenX('note movement7', 6, 600, 0.1, 'cubeInOut')
        noteTweenX('note movement8', 7, 655, 0.1, 'cubeInOut')
        debugPrint("Tightscroll On")
    else
        noteTweenAlpha('note movement1', 0, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 1, 0.1, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 1, 0.1, 'cubeInOut')
        noteTweenX('note movement5', 4, 732, 0.1, 'cubeInOut')
        noteTweenX('note movement6', 5, 844, 0.1, 'cubeInOut')
        noteTweenX('note movement7', 6, 956, 0.1, 'cubeInOut')
        noteTweenX('note movement8', 7, 1068, 0.1, 'cubeInOut')
        debugPrint("Tightscroll Off")
    end
    q = (q == 1) and 0 or 1
end

-- Playback rate modifier functions
function modifyPlaybackRate()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Z') then
        if getProperty('playbackRate') > 0.2 then
            setProperty('playbackRate', getProperty('playbackRate') - 0.05)
            debugPrint("Playback Rate - 0.05")
        end
    end

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.X') then
        if getProperty('playbackRate') < 3 then
            setProperty('playbackRate', getProperty('playbackRate') + 0.05)
            debugPrint("Playback Rate + 0.05")
        end
    end
end

-- Key listener for various debug commands
function onUpdate()
    -- Debug key actions
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.O') then toggleOpponentStrums() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.P') then togglePlayerStrums() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.C') then toggleHUD() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.T') then toggleHealthDrain() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then toggleHealthGain() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.I') then toggleInstrumentalMute() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.V') then toggleVoicesMute() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.B') then toggleBotPlay() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.N') then togglePracticeMode() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.E') then resetDebugCommands() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.M') then toggleMiddleScroll() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.U') then toggleSpreadScroll() end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Q') then toggleTightScroll() end
    -- Scroll speed and playback rate modifications
    modifyPlaybackRate()
end
