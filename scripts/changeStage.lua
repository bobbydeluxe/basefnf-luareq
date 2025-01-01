function onCreatePost()
    if not stringEndsWith(curStage, 'Erect') and stringEndsWith(songName, 'Erect') then
        if checkFileExists('stages/'..curStage..'Erect.json') then
            makeLuaSprite('blackScreen')
            makeGraphic('blackScreen', screenWidth * 2, screenHeight * 2, '000000')
            setObjectToCamera('blackScreen', 'camOther')
            screenCenter('blackScreen')
            addLuaSprite('blackScreen')

            setPropertyFromClass('states.PlayState', 'SONG.stage', curStage..'Erect')
            if getPropertyFromClass('states.PlayState', 'SONG.stage') == 'spookyErect' then
                local characterDataFile = {'player1', 'player2', 'gfVersion'}
                for i, character in ipairs({'boyfriend', 'dad', 'gf'}) do
                    if checkFileExists('characters/'.._G[character..'Name']..'-dark.json') then
                        setPropertyFromClass('states.PlayState', 'SONG.'..characterDataFile[i], _G[character..'Name']..'-dark')
                    end
                end
            end
            restartSong()
        end
    end
end

function setObjectToCamera(object, camera)
    if version == '1.0' then
        setProperty(object..'.camera', instanceArg(camera), false, true)
    else
        setObjectCamera(object, camera)
    end
end
