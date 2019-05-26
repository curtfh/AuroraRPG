
set FROM="client.lua"
set TO="client.luac"
curl.exe -s -X POST -F compile=1 -F debug=0 -F obfuscate=0 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
