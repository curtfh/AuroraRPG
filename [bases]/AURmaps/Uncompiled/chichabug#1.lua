for i,v in ipairs({
    {3095,2548.2,1057.4,10,90,90,0},
    {3095,2548.2,1055.5,10,90,90,0},
    {3095,2544.2,1061.4,10,90,90,90},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setObjectScale(obj, 1)
    setElementDimension(obj, 0)
    setElementInterior(obj, 0)
    setElementDoubleSided(obj, true)
end