Objects = {



createObject ( 897, 695.20001, 851, -41 ),
createObject ( 897, 696.5, 856.7002, -40 ),
createObject ( 897, 699.5, 862, -41 ),
createObject ( 897, 701.79999, 866.29999, -38 ),
createObject ( 897, 701.70001, 873.20001, -41, 0, 0, 18 ),
createObject ( 897, 702.7002, 869.40039, -41 ),
createObject ( 897, 700.7002, 859.5, -38 ),
createObject ( 897, 703.20001, 864.09998, -36.5, 0, 252, 102 ),
createObject ( 897, 703.40039, 872.2998, -36.7, 0, 313.995, 46 ),
createObject ( 5816, 461.29999, 889.29999, -23.1, 0, 0, 270 ),
createObject ( 16304, 467.89999, 890.40002, -28.6 ),
createObject ( 16304, 499.89999, 810.09998, -20 ),

}



for index, object in ipairs ( Objects ) do

	setElementDoubleSided ( object, true )

end