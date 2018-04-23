local composer = require( "composer" )
 
local scene = composer.newScene()

math.randomseed(os.time())
local quad = {}
local circ = {}
local text = {}
local w = display.contentWidth
local h = display.contentHeight
local vX = 340  
local vY = 170
local phy = require("physics")
local vida = {}
local placar = {}
local passosX = 0
local passosY = 0
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function showScene1()
    print("entrou no show")
    composer.gotoScene("scene1")
end

function scene:create( event )
 
    local sceneGroup = self.view
    local sheetData = {
        width = 68, --largura de cada frame
        height = 53, -- altura de cada frame
        numFrames = 14 -- total de numero de frames 
    }
    
    local sheet = graphics.newImageSheet("imagens/voar.png", sheetData)
    
    local sequenceData = {
        -- tabela de tabelas
        {name = "paradoBaixo", start = 1, count = 1, time = 0, loopCount = 1},
        {name = "paradoEsquerda", start = 4, count = 1, time = 0, loopCount = 1},
        {name = "paradoDireita", start = 7, count = 1, time = 0, loopCount = 1},
        {name = "paradoCima", start = 10, count = 1, time = 0, loopCount = 1},
        {name = "moveBaixo", start = 2, count = 2, time = 300, loopCount = 0},
        {name = "moveEsquerda", start = 8, count = 14, time = 300, loopCount = 0},
        {name = "moveDireita", start = 1, count = 7, time = 300, loopCount = 0},
        {name = "moveCima", start = 11, count = 2, time = 300, loopCount = 0}
    
    }
    
    --Personagem
    local player = display.newSprite(sceneGroup,sheet, sequenceData)
    player.x = w *.5
    player.x = h *.5
    player.myName = "personagem"
    player:setSequence("paradoBaixo") --define como vai aparecer na tela
    
    -- Objeto
    
    phy.start()
    phy.setGravity(0,0)
    phy.addBody(player, "static")
    
    --Botoes
    quad[2] = display.newImageRect(sceneGroup,"imagens/seta.png", 70,70)
    quad[2].myName = "direita"
    quad[2].x = 140 + vX
    quad[2].y = 430 - vY
    quad[2]:toFront()
    
    quad[3] = display.newImageRect(sceneGroup,"imagens/seta.png", 70,70)
    quad[3].myName = "esquerda"
    quad[3].x = 60 + vX
    quad[3].y = 430 - vY
    quad[3].rotation = 180
    quad[3]:toFront()
    
    quad[4] = display.newImageRect(sceneGroup,"imagens/seta.png", 70,70)
    quad[4].myName = "cima"
    quad[4].x = 100 + vX
    quad[4].y = 390 - vY
    quad[4].rotation = 270
    quad[4]:toFront()
    
    quad[5] = display.newImageRect(sceneGroup,"imagens/seta.png", 70,70)
    quad[5].myName = "baixo"
    quad[5].x = 100 + vX
    quad[5].y = 470 - vY
    quad[5].rotation = 90
    quad[5]:toFront()
    
    
    
 
    
    placar[3] = 0
    placar[1] = display.newText(sceneGroup,"Pontos:",200,0,native.systemFont, 20)
    placar[2] = display.newText(sceneGroup,placar[3],250,0,native.systemFont, 18)
    
    local function moverTouch(e)
        if e.phase == "began" or e.phase == "moved" then
            if e.target.myName == "direita" then
                passosX =  3
                player:setSequence("moveDireita")
            elseif e.target.myName == "esquerda" then
                passosX = -3
                player:setSequence("moveEsquerda")
            elseif e.target.myName == "cima" then
                passosY = -3
                passosX = 0
                player:setSequence("moveCima")
            elseif e.target.myName == "baixo" then
                passosY = 3
                passosX = 0
                player:setSequence("moveBaixo")
            end
        elseif e.phase == "ended" then
            passosX = 0
            passosY = 0
            if e.target.myName == "direita" then
                player:setSequence("paradoDireita")
            elseif e.target.myName == "esquerda" then
                player:setSequence("paradoEsquerda")
            elseif e.target.myName == "cima" then
                player:setSequence("paradoCima")
            elseif e.target.myName == "baixo" then
                player:setSequence("paradoBaixo")
            end
        end
        
    end
    local aux = 9
    
    --timer.performWithDelay(500, desenhaCab(), 1)
    local function colisao(e)
        --detecta colisao 
        --if(e.phase == "began" and e.object1.myName == "personagem" and e.object2.myName == "cabaca") then
        --end
    end
    
    local function update(e)
        player.x = player.x + passosX
        player.y = player.y + passosY
    
        if(player.x < 40) then
            player.x = 40  
        elseif (player.x > 280) then
            player.x = 280
        end
        
        if(player.y < 0) then
            player.y = 0
        elseif (player.y > 470) then
            player.y = 470
        end
    
        player:play()
    end
    
    local btnVoltar = display.newImageRect(sceneGroup,"imagens/seta.png", 70,70)
    btnVoltar.rotation = 180;
    btnVoltar.x = 0
    btnVoltar.y = 30

    btnVoltar:addEventListener("tap", showScene1)
    quad[2]:addEventListener("touch", moverTouch)
    quad[3]:addEventListener("touch", moverTouch)
    quad[4]:addEventListener("touch", moverTouch)
    quad[5]:addEventListener("touch", moverTouch)
    Runtime:addEventListener("collision", colisao)
    Runtime:addEventListener("enterFrame", update)

 
end
 
 
-- show()
function scene:show( event )
 
end

function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        placar[3] = 0
        placar[2].text = placar[3]
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
-- -----------------------------------------------------------------------------------
 
return scene