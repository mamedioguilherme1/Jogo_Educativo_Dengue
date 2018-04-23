local composer = require( "composer" )
local scene = composer.newScene()

local ret = {}
local text = {}
local largura = 70
local altura = 70

local function showScene2()
    composer.gotoScene("scene2")
end

function scene:create( event )
 
    local sceneGroup = self.view


    ret[11] = display.newImageRect(sceneGroup,"imagens/btnStart.png", 130,70)
    ret[11].x = 240
    ret[11].y = 200
    ret[11]:addEventListener("tap", showScene2)
 
end


-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        
 
    elseif ( phase == "did" ) then
        
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
    
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene