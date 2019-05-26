function getCurrentTax ()
	return getElementData(root, "AURtax.tax", taxpercent)
end 

if (fileExists("client.lua")) then fileDelete("client.lua") end