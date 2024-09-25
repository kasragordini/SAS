*;
*;
Title 'BIA 654 Final Project';
Options Linesize = 80 ps=50 pageno=1;
*; 
* Import Data
*;
*;
PROC IMPORT OUT= WORK.Prop 
            DATAFILE= "\\apporto.com\dfs\STVN\Users\rrouse_stvn\Desktop\
Project\ProjectData.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
*;
Proc Sort Data = Prop;
	By Company City Style;
*;
Proc Print DATA = Prop;
*;
* a. Exploratory Data Analysis
* b. ANOVA Omnibus F Test
* c. Multiple Comparison Tests - REGWQ and Tukey
* d. Orthogonal Contrasts
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
*;
Title "COMPLETELY RANDOMIZED DEISGN (CRD) ANALYSIS - By City";
*;
Proc GLM Data = Prop;
	Class City;
	Model EBITDA = City;
	Means City;
	Means City / REGWQ tukey;
*;
* Selected Orthogonal Contrasts;
*;
	CONTRAST "Gibsonville vs. Burlington" City 1 -1 0 0 0 0;
	CONTRAST "Gibsonville vs. Eden" City 1 0 0 0 0 -1;
	CONTRAST "Reidsville vs. Eden" City 0 0 0 0 1 -1;
*;
Title "COMPLETELY RANDOMIZED DEISGN (CRD) ANALYSIS - By Style";
*;
Proc GLM Data = Prop;
	Class Style;
	Model EBITDA = Style;
	Means Style;
	Means Style / REGWQ tukey;
*;
* Selected Orthogonal Contrasts;
*;
	CONTRAST "Quad vs. Single family" Style 0 1 0 0 -1 0;
	CONTRAST "Boarding single family vs. Single family" Style 1 -1 0 0 0 0;
	CONTRAST "Duplex vs. Triplex" Style 0 0 1 -1 0 0;
*;
Title "RANDOMIZED BLOCK DESIGN (RBD) ANALYSIS - By City - Block for Company";
*;
Proc GLM Data = Prop
			Plots = (Diagnostics Residuals)
			Plots (Unpack) = Residuals;
	Class City Company;
		Model EBITDA = City Company;
		Means City/regwq tukey;
*;
Proc GLM Order = Data;
		Class City Company;
		Model EBITDA = City Company;
		Output Out = New Predicted = Yhat;
*;
Proc GLM Order = Data;
		Class City Company;
		Model EBITDA = City Company Yhat*Yhat/ss1;
		Title "Tukey's Test for Non Additivity";
*;
Title "RANDOMIZED BLOCK DESIGN (RBD) ANALYSIS - By Style - Block for Company";
*;
Proc GLM Data = Prop
			Plots = (Diagnostics Residuals)
			Plots (Unpack) = Residuals;
	Class Style Company;
		Model EBITDA = Style Company;
		Means Style/regwq tukey;
*;
Proc GLM Order = Data;
		Class Style Company;
		Model EBITDA = Style Company;
		Output Out = New Predicted = Yhat2;
*;
Proc GLM Order = Data;
		Class Style Company;
		Model EBITDA = Style Company Yhat2*Yhat2/ss1;
		Title "Tukey's Test for Non Additivity";
*;
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
*;
Title "RANDOMIZED BLOCK FACTORIAL DESIGN (RBF) ANALYSIS";
*;
Proc GLM Data = Prop;
	Class City Style Company;
	Model EBITDA = City Style City*Style Company;
	Means City Style City*Style;
	Means City Style/Regwq Tukey Bon;
*;
	Lsmeans City Style City*Style;
*;
	Lsmeans City / pdiff adjust = tukey;
	Lsmeans Style / pdiff adjust = tukey;
	Lsmeans City*Style / pdiff adjust = tukey;
*;
Title "COMPLETELY RANDOMIZED ANALYSIS OF COVARIANCE (CRAC) ANALYSIS - By City";
Data Prop;
	Set Prop;
		A = City;
		Y = EBITDA;
		X = ResaleValue;
		Label A = "City"
				Y = "EBITDA"
				X = "ResaleValue";
*;
Proc GLM Data = Prop; /* Performs an ANOVA*/
	Class A;
		Model Y = A;
*;
Proc GLM Data = Prop; /*Performs Simple Linear Regression of EBITDA on ResaleValue*/
	Model Y = X;
*;
Proc Sort Data = Prop;
	By A;
Proc GLM Data = Prop; /*Performs Simple Linear Regression of EBITDA on ResaleValue within each level of City*/
	Model Y = X;
	By A;
*;
Proc GLM Data = Prop; /* Tests Homogeneity of Regression Slopes */
	Class A;
		Model Y = A X A*X;
*;
Proc GLM Data = Prop; /* Performs an ANCOVA */
	Class A;
	Model Y = A X;
	Means A;
	LSMeans A / StdErr PDiff Adjust = Tukey;
*;
Title "COMPLETELY RANDOMIZED ANALYSIS OF COVARIANCE (CRAC) ANALYSIS - By Style";
Data Prop;
	Set Prop;
		B = Style;
		Y = EBITDA;
		X = ResaleValue;
		Label B = "Style"
				Y = "EBITDA"
				X = "ResaleValue";
*;
Proc GLM Data = Prop; /* Performs an ANOVA*/
	Class B;
		Model Y = B;
*;
Proc GLM Data = Prop; /*Performs Simple Linear Regression of EBITDA on ResaleValue*/
	Model Y = X;
*;
Proc Sort Data = Prop;
	By B;
Proc GLM Data = Prop; /*Performs Simple Linear Regression of EBITDA on ResaleValue within each level of Style*/
	Model Y = X;
	By B;
*;
Proc GLM Data = Prop; /* Tests Homogeneity of Regression Slopes */
	Class B;
		Model Y = B X B*X;
*;
Proc GLM Data = Prop; /* Performs an ANCOVA */
	Class B;
	Model Y = B X;
	Means B;
	LSMeans B / StdErr PDiff Adjust = Tukey;
*;
Run;
*;
	ODS Graphics Off;
*;
Quit;
