
set FROM="ppEvent_c.lua"
set TO="ppEvent_c.luac"
curl.exe -s -X POST -F compile=1 -F debug=0 -F obfuscate=0 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
