for i,v in ipairs({
    {17298,1941.7,162.3,41.7,0,0,344},
    {17324,1919.7,161.7,36.2,0,0,162},
    {1458,1932.4,169.39999,36.3,0,0,0},
    {1483,1936.1,167,38.2,0,0,342},
    {3252,1911.5,174.60001,36.3,0,0,0},
    {12918,1917.7,165.10001,36.2,0,0,74},
    {1408,1908.7,177.39999,36.8,0,0,166},
    {1408,1950.8,165,36.7,0,0,165.998},
    {1408,1914,176.09961,36.9,0,0,165.998},
    {1408,1903.4,178.7,36.7,0,0,165.998},
    {1408,1902,177,36.7,0,0,297.998},
    {1408,1904.5,172.2,36.8,0,0,297.993},
    {1408,1903,162,36.7,0,0,249.993},
    {1408,1904.9004,167.2002,36.7,0,0,249.988},
    {1408,1902.9,156.89999,36.7,0,0,287.989},
    {1408,1906.4,153.60001,36.6,0,0,343.985},
    {672,1950.8,159.10001,35.9,0,0,58},
    {691,2013.1,231.2,25.6,0,0,0},
    {691,2015.1,211.39999,24.7,0,0,0},
    {691,2013.6,185.2,25.2,0,0,0},
    {700,1909,241.2,28.2,0,0,0},
    {700,1904.7,214.5,30,0,0,0},
    {700,1905.5996,228.2002,28,0,0,0},
    {700,1904.4,200.60001,32.7,0,0,0},
    {700,1906.2,188.89999,34.9,0,0,0},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setObjectScale(obj, 1)
    setElementDimension(obj, 0)
    setElementInterior(obj, 0)
    setElementDoubleSided(obj, true)
	setObjectBreakable(obj, false)
end