

set FROM="phone.lua"
set TO="phone.luac"
curl.exe -s -X POST -F compile=1 -F debug=0 -F obfuscate=0 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%

