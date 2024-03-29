interviewWidget = nil
btnOpenInterview = nil
interviewWindow = true

function init()
  btnOpenInterview = modules.client_topmenu.addRightGameToggleButton('btnOpenInterview', 
    tr('Job Interview') .. ' (Ctrl+Y)', '/images/topbuttons/testIcon', toggle)
  
  btnOpenInterview:setOn(false)
  interviewWindow = g_ui.displayUI('interview', modules.game_interface.getRightPanel())
  
  g_keyboard.bindKeyDown('Ctrl+Y', toggle)
  interviewWindow:hide()
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
 
  if g_game.isOnline() then
    online()
  end
end

function terminate()
  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  
  g_keyboard.unbindKeyDown('Ctrl+Y')

  interviewWindow:destroy()
  btnOpenInterview:destroy()
end

function jump ()
  local btnJump = interviewWindow:getChildById('btnJump')
  local minY = interviewWindow:getY() + btnJump:getHeight()
  local maxY = interviewWindow:getY() + interviewWindow:getHeight() - btnJump:getHeight()
  
  btnJump:setY(math.random(minY, maxY))
  btnJump:setX(interviewWindow:getX() + interviewWindow:getWidth() - btnJump:getWidth() - 10)
end

function horizontalMove ()  
  local btnJump = interviewWindow:getChildById('btnJump')
  local newXpos = btnJump:getX() - 1
  
  if newXpos < (interviewWindow:getX() + 10) then
    newXpos = interviewWindow:getX() + interviewWindow:getWidth() - btnJump:getWidth() - 10
  end
  
  btnJump:setX(newXpos)  
  scheduleEvent(horizontalMove, 10)
end

function toggle()
  if btnOpenInterview:isOn() then
    btnOpenInterview:setOn(false)
    interviewWindow:hide()    
  else
	btnOpenInterview:setOn(true)
    interviewWindow:show()	
	horizontalMove()
  end
end

function onMiniWindowClose()
  btnOpenInterview:setOn(false)
end
