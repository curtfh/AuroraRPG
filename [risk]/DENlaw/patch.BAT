set FROM="clientside.lua"
set TO="clientside.luac"
curl.exe -s -X POST -F compile=1 -F debug=0 -F obfuscate=0 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
