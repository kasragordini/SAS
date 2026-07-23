/* Mock substitute for the external PROC IMPORT (ProjectData.xlsx is not in the repo). */
/* Columns match what the analysis reads: Company City Style EBITDA ResaleValue. */
data Prop;
  length Company $8 City $12 Style $10;
  input Company $ City $ Style $ EBITDA ResaleValue;
datalines;
Alpha Gibsonville Quad 130.4 1143.4
Alpha Gibsonville Single 112.6 1090.5
Alpha Gibsonville Boarding 125.5 1089.7
Alpha Gibsonville Duplex 120.3 1098.6
Alpha Burlington Quad 110.1 1065.3
Alpha Burlington Single 93.9 1023.5
Alpha Burlington Boarding 108.6 1058.9
Alpha Burlington Duplex 96.0 977.8
Alpha Eden Quad 125.0 1157.8
Alpha Eden Single 106.2 1043.4
Alpha Eden Boarding 121.1 1072.3
Alpha Eden Duplex 110.8 1077.6
Alpha Reidsville Quad 109.5 1053.9
Alpha Reidsville Single 89.5 982.1
Alpha Reidsville Boarding 104.1 1009.4
Alpha Reidsville Duplex 96.3 966.6
Alpha Graham Quad 117.5 1078.3
Alpha Graham Single 106.3 1068.4
Alpha Graham Boarding 125.7 1097.5
Alpha Graham Duplex 119.4 1076.4
Alpha Mebane Quad 112.7 1066.0
Alpha Mebane Single 95.5 1021.6
Alpha Mebane Boarding 110.6 1073.3
Alpha Mebane Duplex 103.6 1047.1
Beta Gibsonville Quad 118.5 1079.8
Beta Gibsonville Single 101.1 1037.1
Beta Gibsonville Boarding 115.0 1141.4
Beta Gibsonville Duplex 105.7 1016.5
Beta Burlington Quad 104.1 1072.8
Beta Burlington Single 85.0 977.9
Beta Burlington Boarding 101.7 1024.8
Beta Burlington Duplex 83.3 936.6
Beta Eden Quad 117.8 1058.7
Beta Eden Single 96.1 1010.0
Beta Eden Boarding 107.7 1070.4
Beta Eden Duplex 104.3 1096.1
Beta Reidsville Quad 98.5 998.5
Beta Reidsville Single 75.8 897.6
Beta Reidsville Boarding 94.8 984.0
Beta Reidsville Duplex 83.7 970.3
Beta Graham Quad 115.1 1076.1
Beta Graham Single 92.6 961.9
Beta Graham Boarding 110.7 1075.3
Beta Graham Duplex 110.8 1064.9
Beta Mebane Quad 104.0 1041.0
Beta Mebane Single 89.3 997.4
Beta Mebane Boarding 99.1 990.9
Beta Mebane Duplex 94.6 1006.8
Gamma Gibsonville Quad 131.9 1153.2
Gamma Gibsonville Single 116.8 1081.6
Gamma Gibsonville Boarding 128.4 1142.2
Gamma Gibsonville Duplex 112.9 1046.0
Gamma Burlington Quad 106.4 1082.5
Gamma Burlington Single 92.3 1004.9
Gamma Burlington Boarding 92.5 1006.3
Gamma Burlington Duplex 97.2 994.5
Gamma Eden Quad 117.5 1093.4
Gamma Eden Single 108.9 1031.0
Gamma Eden Boarding 113.3 1109.9
Gamma Eden Duplex 106.2 1036.9
Gamma Reidsville Quad 102.4 999.0
Gamma Reidsville Single 84.9 926.3
Gamma Reidsville Boarding 100.5 1022.2
Gamma Reidsville Duplex 99.1 1023.2
Gamma Graham Quad 129.5 1111.3
Gamma Graham Single 105.5 1051.2
Gamma Graham Boarding 126.0 1087.2
Gamma Graham Duplex 116.0 1102.0
Gamma Mebane Quad 115.1 1101.2
Gamma Mebane Single 91.2 970.0
Gamma Mebane Boarding 99.0 1020.7
Gamma Mebane Duplex 96.2 1054.5
Delta Gibsonville Quad 119.6 1110.3
Delta Gibsonville Single 97.7 1000.5
Delta Gibsonville Boarding 118.0 1116.2
Delta Gibsonville Duplex 115.8 1085.3
Delta Burlington Quad 97.5 1020.9
Delta Burlington Single 86.1 973.9
Delta Burlington Boarding 94.2 1024.0
Delta Burlington Duplex 90.4 997.2
Delta Eden Quad 120.1 1119.7
Delta Eden Single 98.1 1065.8
Delta Eden Boarding 111.0 1058.8
Delta Eden Duplex 103.4 1071.3
Delta Reidsville Quad 97.5 1022.5
Delta Reidsville Single 83.8 939.1
Delta Reidsville Boarding 85.1 964.9
Delta Reidsville Duplex 85.9 945.6
Delta Graham Quad 122.5 1129.7
Delta Graham Single 97.0 1020.4
Delta Graham Boarding 113.2 1038.4
Delta Graham Duplex 108.8 1055.8
Delta Mebane Quad 101.0 1037.3
Delta Mebane Single 88.0 955.2
Delta Mebane Boarding 100.6 1047.9
Delta Mebane Duplex 89.1 983.7
;
run;

Title "COMPLETELY RANDOMIZED FACTORIAL DESIGN (CRF) ANALYSIS";
*;
Proc GLM Data = Prop;
	Class City Style;
	Model EBITDA = City Style City*Style;
	Means City Style City*Style;
	Means City Style/Regwq Tukey Bon;
*;
	Lsmeans City Style City*Style;
*;
	Lsmeans City / pdiff adjust = tukey;
	Lsmeans Style / pdiff adjust = tukey;
	Lsmeans City*Style / pdiff adjust = tukey;
Run;
Quit;
