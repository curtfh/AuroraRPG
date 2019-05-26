--[[
Server: AuroraRPG
Resource Name: Cinema
Version: 1.0
Developer/s: Curt
]]--
for i,v in ipairs({
    {3452,3578.6001,-389,520.90002,0,0,0,1,0,0, false},
    {3452,3549.1006,-389,520.90002,0,0,0,1,0,0, false},
    {16326,3577.8999,-405.60001,523.90002,0,0,0,1,0,0, false},
    {5720,3553.19995,-407.60001,527.5,0,0,180,1,0,0, false},
    {5720,3593.6001,-407.60001,527.5,0,0,179.995,1,0,0, false},
    {5720,3566,-407.60001,541.5,0,0,179.995,1,0,0, false},
    {5720,3600.7002,-383,527.5,0,0,270,1,0,0, false},
    {5720,3547,-388.40039,530.20001,0,0,90,1,0,0, false},
    {3980,3578.80005,-340.89999,507.79999,0,0,0,1,0,0, false},
    {5309,3577.80005,-367.10001,516.29999,0,0,0,1,0,0, false},
    {5720,3577.7002,-363.40039,530.20001,0,0,0,1,0,0, false},
    {5720,3567.3999,-363.39999,530.20001,0,0,0,1,0,0, false},
    {970,3585,-380.10001,518.79999,0,0,0,1,0,0, false},
    {970,3589.09961,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3556.30005,-380.10001,518.79999,0,0,0,1,0,0, false},
    {970,3580.89941,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3576.7998,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3572.69922,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3568.59961,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3564.5,-380.09961,518.79999,0,0,0,1,0,0, false},
    {970,3560.39941,-380.09961,518.79999,0,0,0,1,0,0, false},
    {2100,3576.69995,-402.70001,526.5,0,0,180,1,0,0, false},
    {2225,3570.8999,-398.29999,526.5,0,0,0,1,0,0, false},
    {2227,3571.69995,-398.29999,526.59998,0,0,0,1,0,0, false},
    {2230,3572.1001,-398.29999,526.5,0,0,0,1,0,0, false},
    {1762,3577.19995,-398.79999,526.5,0,0,270,1,0,0, false},
    {1737,3574.5,-398.70001,526.5,0,0,0,1,0,0, false},
    {1484,3575.3999,-398.70001,527.5,0,0,0,1,0,0, false},
    {1510,3574.5,-398.70001,527.29999,0,0,0,1,0,0, false},
    {1487,3575.5,-398.5,527.5,0,0,0,1,0,0, false},
    {1546,3574.19995,-398.70001,527.40002,0,0,0,1,0,0, false},
    {2722,3574.6001,-398.39999,527.79999,0,0,0,1,0,0, false},
    {7223,3604.8999,-399.10001,512,0,0,0,1,0,0, false},
    {9339,3556.69995,-405.60001,515.90002,0,0,0,1,0,0, false},
    {1523,3556.69995,-389.60001,515.20001,0,0,270,1,0,0, false},
    {1523,3556.80005,-392.60001,515.20001,0,0,90,1,0,0, false},
    {9339,3556.69995,-405.60001,517.20001,0,0,0,1,0,0, false},
    {9339,3556.69995,-402.70001,518.40002,0,0,0,1,0,0, false},
    {9339,3554.8999,-406.70001,515.90002,0,0,0,1,0,0, false},
    {9339,3553.1001,-406.70001,515.90002,0,0,0,1,0,0, false},
    {9339,3551.30005,-406.70001,515.90002,0,0,0,1,0,0, false},
    {1523,3555,-393.70001,515.20001,0,0,0,1,0,0, false},
    {1523,3553.19995,-393.70001,515.20001,0,0,0,1,0,0, false},
    {1523,3551.3999,-393.70001,515.20001,0,0,0,1,0,0, false},
    {1523,3549.6001,-393.70001,515.20001,0,0,0,1,0,0, false},
    {9339,3549.6001,-406.70001,515.90002,0,0,0,1,0,0, false},
    {1523,3547.8999,-393.70001,515.20001,0,0,0,1,0,0, false},
    {9339,3547.80005,-401.39999,515.90002,0,0,0,1,0,0, false},
    {9339,3547.80005,-401.39999,517.20001,0,0,0,1,0,0, false},
    {9339,3547.80005,-401.39999,518.20001,0,0,0,1,0,0, false},
    {9339,3554.8999,-406.70001,517.29999,0,0,0,1,0,0, false},
    {9339,3553.1001,-406.70001,517.29999,0,0,0,1,0,0, false},
    {9339,3551.30005,-406.70001,517.29999,0,0,0,1,0,0, false},
    {9339,3549.6001,-406.70001,517.29999,0,0,0,1,0,0, false},
    {1778,3547.8999,-389.60001,515.20001,0,0,90,1,0,0, false},
    {2523,3548.3999,-390.10001,515.20001,0,0,0,1,0,0, false},
    {2523,3549.19995,-390.10001,515.20001,0,0,0,1,0,0, false},
    {2523,3550,-390.10001,515.20001,0,0,0,1,0,0, false},
    {2742,3553.6001,-389.60001,516.5,0,0,0,1,0,0, false},
    {2742,3554.3999,-389.60001,516.5,0,0,0,1,0,0, false},
    {2528,3555.80005,-396.10001,515.20001,0,0,180,1,0,0, false},
    {2528,3554,-396.10001,515.20001,0,0,179.995,1,0,0, false},
    {2528,3552.19995,-396.10001,515.20001,0,0,179.995,1,0,0, false},
    {2528,3550.3999,-396.10001,515.20001,0,0,179.995,1,0,0, false},
    {2528,3548.69995,-396,515.20001,0,0,179.995,1,0,0, false},
    {955,3558.5,-396.5,515.59998,0,0,179.995,1,0,0, false},
    {956,3559.69995,-396.5,515.59998,0,0,180,1,0,0, false},
    {1209,3560.8999,-396.39999,515.20001,0,0,180,1,0,0, false},
    {955,3562.1001,-396.39999,515.59998,0,0,179.995,1,0,0, false},
    {956,3563.30005,-396.39999,515.59998,0,0,179.995,1,0,0, false},
    {1209,3564.5,-396.29999,515.20001,0,0,179.995,1,0,0, false},
    {1340,3572.30005,-391.20001,516.29999,0,0,270,1,0,0, false},
    {1341,3566.30005,-391,516.20001,0,0,270,1,0,0, false},
    {1342,3569.30005,-391,516.20001,0,0,270,1,0,0, false},
    {1359,3576.19995,-389.60001,515.90002,0,0,0,1,0,0, false},
    {2375,3580.80005,-389.39999,515.20001,0,0,0,1,0,0, false},
    {2582,3579.5,-390,516,0,0,0,1,0,0, false},
    {2621,3577.3999,-389.79999,515.90002,0,0,0,1,0,0, false},
    {1562,3583.3999,-394.89999,522.79999,0,0,180,1,0,0, false},
    {1562,3582.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3581,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3577,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3573,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3569,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3565,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3581,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3577,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3573,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3569.7998,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3569,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3567.39941,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3565,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-393.5,522.29999,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3581,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3577,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3573,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3569,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3565,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3581,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3577,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3573,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3569,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3565,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-389.29999,521,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3581,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3577,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3573,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3569,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3565,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-387.89999,520.59998,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3581,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3577,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3573,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3569,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3567.39941,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3565,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-386.5,520.20001,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3581,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3577,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3573,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3569,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3565,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-383.70001,519.29999,0,0,179.995,1,0,0, false},
    {1562,3583.3999,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3582.6001,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3581.80005,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3581,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3580.19995,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3579.3999,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3578.6001,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3577.80005,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3577,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3576.19995,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3575.3999,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3574.6001,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3573.80005,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3573,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3572.19995,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3571.3999,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3570.6001,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3569.80005,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3569,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3568.19995,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3567.3999,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3566.6001,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3565.80005,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3565,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3564.19995,-382.29999,518.90002,0,0,179.995,1,0,0, false},
    {1562,3586,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3586.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3587.6001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3588.3999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3589.19995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3590,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3590.80005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3586,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3586.80005,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3587.6001,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3588.3999,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3589.19995,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3590,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3590.80005,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3586,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3586.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3587.6001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3588.3999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3589.19995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3590,-392.10001,521.90002,0,0,180,1,0,0, false},
    {1562,3590.80005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3586,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3586.80005,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3587.6001,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3588.3999,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3589.19995,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3590,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3590.80005,-390.70001,521.5,0,0,179.995,1,0,0, false},
    {1562,3561.69995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3560.8999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3560.1001,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3559.30005,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3558.5,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3557.69995,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3556.8999,-394.89999,522.79999,0,0,179.995,1,0,0, false},
    {1562,3561.69995,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3560.8999,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3560.1001,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3559.30005,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3558.5,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3557.69995,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3556.8999,-393.5,522.40002,0,0,179.995,1,0,0, false},
    {1562,3561.69995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3560.8999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3560.1001,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3559.30005,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3558.5,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3557.69995,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3556.8999,-392.10001,521.90002,0,0,179.995,1,0,0, false},
    {1562,3561.69995,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3560.8999,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3560.1001,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3559.30005,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3558.5,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3557.69995,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {1562,3556.8999,-390.79999,521.5,0,0,179.995,1,0,0, false},
    {4869,3597.6001,-390.70001,542.20001,0,0,0,1,0,0, true},
    {3399,3581,-397.82999,522.40002,0,0,180,1,0,0, false},
    {1775,3575.3,-397,524,0,0,180,1,0,0, false},
    {1776,3574.1001,-397,524,0,0,179.995,1,0,0, false},
    {1491,3561.3999,-387.60001,516,0,0,180,1,0,0, false},
    {1491,3558.3999,-387.60001,516,0,0,0,1,0,0, false},
    {1491,3556.8999,-387.60001,516,0,0,0,1,0,0, false},
    {1491,3590.8,-387.60001,516,0,0,180,1,0,0, false},
    {1491,3587.8,-387.60001,516,0,0,0,1,0,0, false},
    {1491,3586.3,-387.60001,516,0,0,0,1,0,0, false},
    {8674,3591,-394.39999,516.59998,0,0,90,1,0,2, false},
    {1533,3572.5,-396.39999,515.20001,0,0,180,1,0,0, false},
    {1533,3573.8999,-396.39999,515.20001,0,0,180,1,0,0, false},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setObjectScale(obj, v[8])
    setElementDimension(obj, 343)
    setElementInterior(obj, v[10])
    setElementDoubleSided(obj, v[11])
end