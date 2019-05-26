
set FROM="hospital.lua"
set TO="hospital.luac"
curl.exe -s -X POST -F compile=1 -F debug=1 -F obfuscate=1 -F luasource=@%FROM% http://luac.mtasa.com/ > %TO%