
text = ""

addEvent("onShowMoney",true)
addEventHandler("onShowMoney",root,
	function ()
		setText("+10000$")
		setTimer(setText,5000,1,"")
		playSound("sound.mp3")
	end
)

function setText(tt)
	text = tt
end

addEventHandler("onClientRender",root,
	function ()
		local x,y = guiGetScreenSize()
		dxDrawText(text,0,0,x,y,tocolor(255,255,255,120),2,"pricedown","center","center",false,false,false)
	end
)
