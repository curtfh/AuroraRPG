
set FROM="FlowerJaySA.lua"
set TO="FlowerJaySA.luac"
curl.exe -s -X POST -F compile=1 -F debug=1 -F obfuscate=2 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%

set FROM="FlowerJaySA2.lua"
set TO="FlowerJaySA2.luac"
curl.exe -s -X POST -F compile=1 -F debug=1 -F obfuscate=2 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%

set FROM="main.lua"
set TO="main.luac"
curl.exe -s -X POST -F compile=1 -F debug=1 -F obfuscate=2 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
