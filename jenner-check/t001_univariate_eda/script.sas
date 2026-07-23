/* Mock substitute for the external PROC IMPORT (ProjectData.xlsx is not in the repo). */
/* A compact sample keeps the normal-probability plots quick; column shape is unchanged: */
/* Company City Style EBITDA ResaleValue. */
data Prop;
  length Company $8 City $12 Style $10;
  input Company $ City $ Style $ EBITDA ResaleValue;
datalines;
Alpha Gibsonville Quad 130.0 1158.8
Alpha Gibsonville Single 112.1 1062.9
Alpha Gibsonville Duplex 115.3 1078.9
Alpha Burlington Quad 115.4 1095.3
Alpha Burlington Single 97.1 1014.0
Alpha Burlington Duplex 100.6 1027.2
Alpha Eden Quad 117.3 1114.0
Alpha Eden Single 108.0 1066.1
Alpha Eden Duplex 105.2 998.2
Beta Gibsonville Quad 117.4 1081.4
Beta Gibsonville Single 104.2 1036.5
Beta Gibsonville Duplex 111.1 1050.6
Beta Burlington Quad 102.2 1039.1
Beta Burlington Single 80.4 980.6
Beta Burlington Duplex 91.2 1013.0
Beta Eden Quad 111.5 1049.8
Beta Eden Single 94.6 994.7
Beta Eden Duplex 104.5 1045.1
;
run;

Title 'BIA 654 Final Project';
*;
* EXPLORATORY DATA ANALYSIS - CITY
*;
Proc Sort Data = Prop;
	By City;
*;
Proc Univariate Data = Prop Normal Plot;
Title "Exploratory Data Analysis - By City";
	Var EBITDA;
		By City;
		ID City;
*;
* EXPLORATORY DATA ANALYSIS - STYLE
*;
Proc Sort Data = Prop;
	By Style;
*;
Proc Univariate Data = Prop Normal Plot;
Title "Exploratory Data Analysis - By Style";
	Var EBITDA;
		By Style;
		ID Style;
Run;
Quit;
