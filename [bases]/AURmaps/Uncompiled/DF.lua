     local Objects =   {
     createObject(18450,1768.2998,-851.2998,68.5,0,341.993,18.248),
     createObject(18450,1839.5,-827.79999,95.8,0,337.994,18.248),
     createObject(18450,1902.5,-807,123.8,0,335.995,18.248),
     createObject(4573,1983.2998,-802,106.2,0,0,17.996),
     createObject(9090,1976.1992,-751.7998,109.7,0,0,107.985),
     createObject(4573,1964.89941,-745.19922,106.2,0,0,17.996),
     createObject(4573,1952.59961,-707.2998,106.2,0,0,17.996),
     createObject(4585,2031.59961,-695.2998,31.7,0,0,17.996),
     createObject(4585,2043.19995,-730.90002,31.8,0,0,17.996),
     createObject(4585,2054.5,-765.59961,31.9,0,0,17.996),
     createObject(4585,2020.09998,-659.90002,31.8,0,0,17.996),
     createObject(4585,2007.7998,-623.09961,31.8,0,0,17.996),
     createObject(4573,1987.7998,-695.89941,99.6,0,0,17.996),
     createObject(4573,2003,-742.40002,100.2,0,0,17.996),
     createObject(4573,2018.5,-770.5,99.5,0,0,17.996),
     createObject(8210,2046.2998,-792.2998,132.5,0,0,17.996),
     createObject(3749,1954.09961,-790.09961,146.3,0,0,287.996),
     createObject(8155,1991.89941,-809,142.7,0,0,107.99),
     createObject(8209,1938.39941,-733.89941,141.8,0,0,287.996),
     createObject(8210,1949.40002,-677.40002,141.89999,0,0,198),
     createObject(3268,2038.80005,-718.70001,131.7,0,0,288),
     createObject(3605,2048.6006,-753.2002,137.39999,0,0,287.573),
     createObject(8355,2020.80005,-662.20001,131.7,0,0,17.996),
     createObject(3604,2054.30005,-779.90002,134.3,0,0,287.789),
     createObject(6356,1996.5,-685,141.10001,0,0,21.995),
     createObject(6356,2007.40002,-729.5,141.7,0,0,347.995),
     createObject(6356,2020.59961,-764.59961,141.7,0,0,347.986),
     createObject(6356,2022.59998,-780.90002,141.5,0,0,345.992),
     createObject(3749,1734.7002,-862.5,62.4,0,0,289.99),
     createObject(16326,1979.7998,-684.19922,130.3,0,0,287.996),
     createObject(3113,1962.40002,-787.5,137.5,0,304,18),
     createObject(3624,1965.7998,-687,141.3,0,0,107.996),
     createObject(6356,1945.90002,-698.90002,148.3,0,0,165.995),
     createObject(9833,1950,-713.2002,140.8,0,0,0),
     createObject(987,2025.5996,-818.90039,138.5,0,0,107.996),
     createObject(987,2022.0996,-808,138.5,0,0,107.996),
     createObject(987,1960.90002,-803.40002,135.60001,0,270,290),
     createObject(3928,2005.09998,-783.5,137.5,0,0,18),
     createObject(8210,1973.19995,-669.70001,133.39999,0,0,198),
     createObject(14394,2002,-672.40002,130.89999,0,0,18),
     createObject(9241,1984.5,-814.20001,139.5,0,0,198),
     createObject(11505,1953.1,-752.59998,141.8,0,0,108),
     createObject(11505,1957.7,-766.5,141.8,0,0,107.996),
     createObject(8131,2005,-784,148.10001,0,0,16.996),
     createObject(3108,2020.7,-664.59998,131.7,0,0,0),
     createObject(2748,2005.9,-818.5,138,0,0,108),
     createObject(2748,2004.2,-813.29999,138,0,0,107.996),
     createObject(2748,2010.5,-817,138,0,0,107.996),
     createObject(2748,2008.9,-811.90002,138,0,0,107.996),
     createObject(2748,2014.5,-815.79999,138,0,0,107.996),
     createObject(2748,2013,-810.79999,138,0,0,107.996),
     createObject(14620,2020.2,-808.70001,137.8,0,0,230),
     createObject(1671,2019.4,-811.79999,137.89999,0,0,290),
     createObject(1671,2022.4,-817.5,137.89999,0,0,289.995),
     createObject(1671,2018.9,-805.29999,137.89999,0,0,289.995),
     createObject(2748,2011.5,-806.59998,138,0,0,107.996),
     createObject(2748,2007.5,-807.90002,138,0,0,107.996),
     createObject(2748,2002.7,-809.40002,138,0,0,107.996),
     createObject(2748,2015.8,-819.70001,138,0,0,107.996),
     createObject(2748,2012,-820.90002,138,0,0,107.996),
     createObject(2748,2007.3,-822.29999,138,0,0,107.996),
     createObject(16782,2021.2,-811.29999,138.60001,0,0,199),
	 }

	
for index, object in ipairs ( Objects ) do

	setElementDoubleSided ( object, true )

	setObjectBreakable(object, false)

end