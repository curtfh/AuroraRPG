
set FROM="server.lua"
set TO="server.luac"
curl.exe -s -X POST -F compile=1 -F debug=1 -F obfuscate=2 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
