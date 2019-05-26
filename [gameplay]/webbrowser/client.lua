screenWidth, screenHeight = guiGetScreenSize()

function isPointInRect(posX, posY, posX1, posY1, posX2, posY2)
	return (posX > posX1 and posX < posX2) and (posY > posY1 and posY < posY2)
end

function showBrowser()
	if WebBrowserGUI.instance ~= nil then return end
	WebBrowserGUI.instance = WebBrowserGUI:new()
end
--bindKey( "F9", "down", showBrowser )

function openBrowser()
	showBrowser()
end
