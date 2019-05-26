for i,v in ipairs({
    {3578,2458.5,-1658.9,11.6,0,0,0},
    {3578,2448.2,-1658.9,11.6,0,0,0},
    {3578,2437.8999,-1658.9,11.6,0,0,0},
    {3578,2427.6001,-1658.9,11.6,0,0,0},
    {3578,2417.3,-1658.9,11.6,0,0,0},
    {3578,2407,-1658.9,11.6,0,0,0},
    {3578,2396.7,-1658.9,11.6,0,0,0},
    {3578,2386.3999,-1658.9,11.6,0,0,0},
    {3578,2376.1001,-1658.9,11.6,0,0,0},
    {3578,2365.8,-1658.9,11.6,0,0,0},
    {3578,2355.5,-1658.9,11.6,0,0,0},
    {1226,2432.1001,-1654.8,16.3,0,0,90},
    {1226,2404.4004,-1654.9004,16.3,0,0,90},
    {1215,2423.1001,-1680.2,13.3,0,0,0},
    {1215,2463.6006,-1653.7002,13,0,0,0},
    {1280,2436.6001,-1680.5,13.2,0,0,270},
    {948,2434.8,-1680.6,12.8,0,0,0},
    {948,2438.2,-1680.6,12.8,0,0,0},
    {1280,2433,-1680.4,13.2,0,0,270},
    {948,2431.2,-1680.5,12.8,0,0,0},
    {1280,2425.8,-1680.3,13.2,0,0,270},
    {948,2427.6001,-1680.5,12.8,0,0,0},
    {1280,2429.3999,-1680.4,13.2,0,0,270},
    {948,2424,-1680.3,12.8,0,0,0},
    {3920,2432.7,-1681.2,16.5,0,0,0},
    {3920,2429.3999,-1681.2,16.5,0,0,0},
    {1215,2463.4004,-1663.9004,13,0,0,0},
    {1215,2439,-1680.4004,13.4,0,0,0},
    {1215,2505.8,-1679.7,13.1,0,0,0},
    {1215,2510.3,-1669.1,13.1,0,0,0},
    {1215,2509,-1662.9,13.2,0,0,0},
    {1215,2508.9004,-1675,13.1,0,0,0},
    {1215,2478.8999,-1683.2,13.1,0,0,0},
    {1215,2502.7002,-1682.2002,13.1,0,0,0},
    {1215,2494.9004,-1684.0996,13.1,0,0,0},
    {1215,2483.6006,-1684.2002,13.1,0,0,0},
    {1215,2483.7,-1653.7,13,0,0,0},
    {1215,2471.7998,-1678.4004,13.1,0,0,0},
    {1215,2469.7002,-1674.9004,13.1,0,0,0},
    {1215,2495.5,-1653.8,13,0,0,0},
    {1215,2505.9004,-1658.2998,13.2,0,0,0},
    {1215,2501.2002,-1655,13,0,0,0},
    {997,2436.1001,-1633.5,12.4,0,0,0},
    {997,2436.2,-1640.4,12.5,0,0,0},
    {997,2436.2002,-1637,12.4,0,0,0},
    {997,2436.2,-1646.7,12.5,0,0,0},
    {997,2436.2002,-1643.5996,12.5,0,0,0},
    {1215,2435.8,-1633.5,13,0,0,0},
    {1215,2435.8,-1637,13,0,0,0},
    {1215,2435.8,-1643.5,13,0,0,0},
    {1215,2435.7998,-1640.4004,13,0,0,0},
    {1215,2435.8,-1646.6,13.1,0,0,0},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setObjectScale(obj, 1)
    setElementDimension(obj, 0)
    setElementInterior(obj, 0)
    setElementDoubleSided(obj, true)
	setObjectBreakable(obj, false)
end