
set FROM="gym_client.lua"
set TO="gym_client.luac"
curl.exe -s -X POST -F compile=1 -F debug=0 -F obfuscate=0 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%
