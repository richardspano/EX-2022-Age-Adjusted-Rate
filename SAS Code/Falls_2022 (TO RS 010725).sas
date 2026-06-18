LIBNAME raw "I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Data\Raw";
LIBNAME derived "I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Data\Derived";


/**************************/
/*Deaths Data 2015 to 2022*/
/**************************/
data Fall;
	set derived.Allinjury_2015_2022;
run;
/*171828 observations and 112 variables*/


DATA Fall2;
	set Fall;

	if substr(UCOD,1,3) in ('W00','W01','W02','W03','W04','W05','W06','W07','W08','W09','W10','W11','W12','W13','W14','W15','W16','W17','W18','W19') then Fall = 1;
	else Fall = 0;

run;
/*171828 observations and 113 variables*/


proc print data=Fall2 (obs=100); run;
where Fall = 1;
run;

proc freq data = Fall2;
table Fall;
where Fall=1 and Death_YR = 2022 and RES_ST2 = "NM" and Ageatdth >= 65;
run;


/*OLDER ADULT FALL DATA*/
data Fall3;
	length Age_cat $ 6 Sex_cat $ 6 Race_cat $ 8 HRegion $ 23 Education_level $ 21 Marital_status $13 COUNTY_RES $10;
	set Fall2; 

	/*Age categorization*/
	if(Ageatdth=0) then Bage=1;
   	if(1<=Ageatdth<=4)then Bage=2;
   	if(5<=Ageatdth<=14) then Bage=3;
   	if(15<=Ageatdth<=17)then  Bage=4;
   	if(18<=Ageatdth<=19)then  Bage=5;
   	if(20<=Ageatdth<=24)then  Bage=6;
   	if(25<=Ageatdth<=34)then  Bage=7;
   	if(35<=Ageatdth<=44)then  Bage=8;
   	if(45<=Ageatdth<=54)then  Bage=9;
   	if(55<=Ageatdth<=64)then  Bage=10;
   	if(65<=Ageatdth<=74) then Bage=11;
   	if(75<=Ageatdth<=84)then  Bage=12;
   	if(Ageatdth=>85) then Bage=13;

	/*Age categorization*/
	if(Ageatdth=0) then Age_cat = "1-";
   	if(1<=Ageatdth<=4)then Age_cat = "1-4";
   	if(5<=Ageatdth<=14) then Age_cat = "5-14";
   	if(15<=Ageatdth<=17)then  Age_cat = "15-17";
   	if(18<=Ageatdth<=19)then  Age_cat = "18-19";
   	if(20<=Ageatdth<=24)then  Age_cat = "20-24";
   	if(25<=Ageatdth<=34)then  Age_cat = "25-34";
   	if(35<=Ageatdth<=44)then  Age_cat = "35-44";
   	if(45<=Ageatdth<=54)then  Age_cat = "45-54";
   	if(55<=Ageatdth<=64)then  Age_cat = "55-64";
   	if(65<=Ageatdth<=74) then Age_cat = "65-74";
   	if(75<=Ageatdth<=84)then  Age_cat = "75-84";
   	if(Ageatdth=>85) then Age_cat = "85+";

	/*Sex*/
	if sex = 1 then Sex_cat = 'Male';
	else if sex = 2 then Sex_cat = 'Female';

	/*Race/Ethnicity*/
	if DOHrace = 0 then Race_cat = 'Asian/PI';
	else if DOHrace = 2 then Race_cat = 'Black';
	else if DOHrace = 3 then Race_cat = 'AI/AN';
	else if DOHrace = 7 then Race_cat = 'Other';
	else if DOHrace = 9 then Race_cat = 'Unknown';
	else if DOHrace = 10 then Race_cat = 'White';
	else if DOHrace = 11 then Race_cat = 'Hispanic';
	
	/*Education Level*/
	if Educlvl = 1 or Educlvl = 2 then Education_level = "Less than High School";
	else if Educlvl = 3 then Education_level = "High School Diploma";
	else if Educlvl = 4 then Education_level = "Some College";
	else if Educlvl = 5 then Education_level = "Associate Degree";
	else if Educlvl = 6 then Education_level = "College Degree";
	else if Educlvl = 7 or Educlvl = 8 then Education_level = "Masters/PhD/Pro";
	else if Educlvl = 9 then Education_level = "Unknown";

	/*Marital Status*/
	if Marry = 1 then Marital_status = 'Never Married';
	else if Marry = 2 then Marital_status = 'Married';
	else if Marry = 3 then Marital_status = 'Widowed';
	else if Marry = 4 then Marital_status = 'Divorced';
	else if Marry = 9 then Marital_status = 'Unknown';

	/*Counties from County of Residence FIPS Codes*/
	if res_co2 = 001 then COUNTY_RES = 'Bernalillo';
	if res_co2 = 003 then COUNTY_RES = 'Catron';
	if res_co2 = 005 then COUNTY_RES = 'Chavez';
	if res_co2 = 006 then COUNTY_RES = 'Cibola';
	if res_co2 = 007 then COUNTY_RES = 'Colfax';
	if res_co2 = 009 then COUNTY_RES = 'Curry';
	if res_co2 = 011 then COUNTY_RES = 'De Baca';
	if res_co2 = 013 then COUNTY_RES = 'Dona Ana';
	if res_co2 = 015 then COUNTY_RES = 'Eddy';
	if res_co2 = 017 then COUNTY_RES = 'Grant';
	if res_co2 = 019 then COUNTY_RES = 'Guadalupe';
	if res_co2 = 021 then COUNTY_RES = 'Harding';
	if res_co2 = 023 then COUNTY_RES = 'Hidalgo';
	if res_co2 = 025 then COUNTY_RES = 'Lea';
	if res_co2 = 027 then COUNTY_RES = 'Lincoln';
	if res_co2 = 028 then COUNTY_RES = 'Los Alamos';
	if res_co2 = 029 then COUNTY_RES = 'Luna';
	if res_co2 = 031 then COUNTY_RES = 'McKinley';
	if res_co2 = 033 then COUNTY_RES = 'Mora';
	if res_co2 = 035 then COUNTY_RES = 'Otero';
	if res_co2 = 037 then COUNTY_RES = 'Quay';
	if res_co2 = 039 then COUNTY_RES = 'Rio Arriba';
	if res_co2 = 041 then COUNTY_RES = 'Roosevelt';
	if res_co2 = 043 then COUNTY_RES = 'Sandoval';
	if res_co2 = 045 then COUNTY_RES = 'San Juan';
	if res_co2 = 047 then COUNTY_RES = 'San Miguel';
	if res_co2 = 049 then COUNTY_RES = 'Santa Fe';
	if res_co2 = 051 then COUNTY_RES = 'Sierra';
	if res_co2 = 053 then COUNTY_RES = 'Socorro';
	if res_co2 = 055 then COUNTY_RES = 'Taos';
	if res_co2 = 057 then COUNTY_RES = 'Torrance';
	if res_co2 = 059 then COUNTY_RES = 'Union';
	if res_co2 = 061 then COUNTY_RES = 'Valencia';
	if res_co2 = 999 then COUNTY_RES = 'Unknown';

	/*Categorizing health regions based on counties*/
	If  res_co2 = 006 or  res_co2 = 031 or  res_co2 = 045 then HRegion = 'Northwest Region';

	If  res_co2 = 007 or  res_co2 = 019 or  res_co2 = 021 or  res_co2 = 028 or  res_co2 = 033 or  res_co2 = 039 or 
	 res_co2 = 047 or  res_co2 = 049 or  res_co2 = 055 or  res_co2 = 059 then HRegion = 'Northeast Region';

	If  res_co2 = 003 or  res_co2 = 013 or  res_co2 = 017 or  res_co2 = 023 or  res_co2 = 029 or  res_co2 = 035 or 
	 res_co2 = 051 or  res_co2 = 053 then HRegion = 'Southwest Region';

	If  res_co2 = 005 or  res_co2 = 009 or  res_co2 = 011 or  res_co2 = 015 or  res_co2 = 025 or  res_co2 = 027 or 
	 res_co2 = 037 or  res_co2 = 041 then HRegion = 'Southeast Region';

	If  res_co2 = 001 or  res_co2 = 043 or  res_co2 = 057 or  res_co2 = 061 then HRegion = 'Metro Region';

	If  res_co2 = 999 then HRegion = 'Unknown';
	
	/* Delete data where resident states is not NM */
	if RES_ST2 ne 'NM' then delete; 

run;
/*165991 observations and 121 variables*/

PROC FORMAT;
	VALUE Bagelabel	
				1 = 'less than 1 yr'
				2 = '1-4 years'
				3 = '5-14 years'
				4 = '15-17 years'
				5 = '18-19 years'
				6 = '20-24 years'
				7 = '25-34 years'
				8 = '35-44 years'
				9 = '45-54 years'
				10 = '55-64 years'
				11 = '65-74 years'
				12 = '75-84 years'
				13 = '85+ years';
RUN;

PROC FREQ data = Fall3;
	table Fall;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE bage*Sex_cat / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
	FORMAT Bage Bagelabel.;
run;

PROC FREQ data = Fall3;
	TABLE COUNTY_RES HRegion / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE Sex_cat*Death_YR / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE Race_cat*Death_YR / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE Education_level*Death_YR / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE Marital_status*Death_YR / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;

PROC FREQ data = Fall3;
	TABLE COUNTY_RES*Death_YR HRegion*Death_YR / nocol norow nopercent;
	where Fall=1 and Death_YR = 2022 and Ageatdth >= 65;
run;


/*RATE CALCULATION*/ 

/************************************************************************/
/*************************SEX by AGE*************************************/
/************************************************************************/
/*Create a data table (named - Age_Sex) from the frequency table using the OUT statement*/
PROC FREQ data = Fall3;
	TABLE Age_cat*Sex_cat / out=Age_Sex nocol norow nopercent /*noprint*/;
	where Fall=1 and Death_YR=2022 and Ageatdth >= 65;
run;

/*Print new data table*/
proc print data = Age_Sex; run;

/*Sort data before transposing*/
proc sort data = Age_Sex;
by Age_cat;
run;

/* Transposing in SAS - https://stats.oarc.ucla.edu/sas/modules/how-to-reshape-data-long-to-wide-using-proc-transpose/*/
/*Transpose to create a wide data from long data with Male and Female as new variables*/
proc transpose data = Age_Sex out = Age_Sex_wide prefix=N;
by Age_cat;
var COUNT;
id Sex_cat;
run;

proc print data = Age_Sex_wide noobs; run;

proc print data = Age_Sex_wide noobs;
var Age_cat NFemale NMale; 
run;

/*Create a new variable Total_Suicide that sums up the suicide counts for males and females*/
data Age_Sex_wide2;
	set Age_Sex_wide;

	Total_Fall = sum (NMale, NFemale);

run; 

proc print data = Age_Sex_wide2 noobs;
var Age_cat NFemale NMale Total_Fall; 
run;

/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Age_Sex_wide2 sumlabel='Totals' noobs;
   var Age_cat NFemale NMale Total_Fall;
   sum NFemale NMale Total_Fall;
run;


/************************************************************************/
/*************************RACE by AGE************************************/
/************************************************************************/
/*Create a data table (named - Age_Sex) from the frequency table using the OUT statement*/
PROC FREQ data = Fall3;
	TABLE Age_cat*Race_cat / out=Age_Race nocol norow nopercent /*noprint*/;
	where Fall=1 and Death_YR=2022 and Ageatdth >= 65;
run;

/*Print new data table*/
proc print data = Age_Race; run;

/*Sort data before transposing*/
proc sort data = Age_Race;
by Age_cat;
run;

/*Transpose to create a wide data from long data with the different races as new variables*/
proc transpose data = Age_Race out = Age_Race_wide prefix=N;
by Age_cat;
var COUNT;
id Race_cat;
run;

proc print data = Age_Race_wide noobs;
var Age_cat NAI_AN NBlack NHispanic NWhite NAsian_PI; 
run;

/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Age_Race_wide sumlabel='Totals' noobs;
   var Age_cat NAI_AN NBlack NHispanic NWhite NAsian_PI;
   sum NAI_AN NBlack NHispanic NWhite NAsian_PI;
run;



/************************************************************************/
/*************************AGE by COUNTY*********************************/
/************************************************************************/
PROC FREQ data = Fall3;
	TABLE Age_cat*COUNTY_RES / out=Age_County nocol norow nopercent /*noprint*/;
	where Fall=1 and Death_YR=2022 and Ageatdth >= 65;
run;

/*Print new data table*/
proc print data = Age_County; run;

/*Sort data before transposing*/
proc sort data = Age_County;
by Age_cat;
run;

/*Transpose to create a wide data from long data with the different counties as new variables*/
proc transpose data = Age_County out = Age_County_wide prefix=N;
by Age_cat;
var COUNT;
id COUNTY_RES;
run;

proc print data = Age_County_wide noobs; run;

proc print data = Age_County_wide noobs;
var Age_cat NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley NRio_Arriba NSan_Juan NSandoval NSanta_Fe NSocorro NTaos 
NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay NSan_Miguel NSierra NCatron NCurry NLea NTorrance; 
run;

/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Age_County_wide sumlabel='Totals' noobs;
var Age_cat NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley NRio_Arriba NSan_Juan NSandoval NSanta_Fe NSocorro NTaos 
NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay NSan_Miguel NSierra NCatron NCurry NLea NTorrance;

sum NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley NRio_Arriba NSan_Juan NSandoval NSanta_Fe NSocorro NTaos NUnknown 
NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay NSan_Miguel NSierra NCatron NCurry NLea NTorrance;
run;


/************************************************************************/
/**********************AGE by HEALTH REGION******************************/
/************************************************************************/
PROC FREQ data = Fall3;
	TABLE Age_cat*HRegion / out=Age_Region nocol norow nopercent /*noprint*/;
	where Fall=1 and Death_YR=2022 and Ageatdth >= 65;
run;

/*Print new data table*/
proc print data = Age_Region; run;

/*Sort data before transposing*/
proc sort data = Age_Region;
by Age_cat;
run;

/*Transpose to create a wide data from long data with the different Nies as new variables*/
proc transpose data = Age_Region out = Age_Region_wide prefix=N;
by Age_cat;
var COUNT;
id HRegion;
run;

proc print data = Age_Region_wide noobs;
var Age_cat NMetro_Region NNortheast_Region NSoutheast_Region NSouthwest_Region NNorthwest_Region NUnknown; 
run;

/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Age_Region_wide sumlabel='Totals' noobs;
var Age_cat NMetro_Region NNortheast_Region NSoutheast_Region NSouthwest_Region NNorthwest_Region NUnknown;
sum NMetro_Region NNortheast_Region NSoutheast_Region NSouthwest_Region NNorthwest_Region NUnknown;
run;


/**********************/
/*MERGE ALL COUNT DATA*/
/**********************/

proc sort data = Age_Sex_wide2;
by Age_cat;
run;

proc sort data = Age_Race_wide;
by Age_cat;
run;

proc sort data = Age_County_wide;
by Age_cat;
run;

proc sort data = Age_Region_wide;
by Age_cat;
run;

data Fall_N;
	merge Age_Sex_wide2 Age_Race_wide Age_County_wide Age_Region_wide;
	by Age_cat;
run;

proc print data=Fall_N; run;

/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Fall_N sumlabel='Totals' noobs; 
var Age_cat NFemale NMale Total_Fall NAI_AN NHispanic NWhite NAsian_PI NBlack NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley 
NRio_Arriba NSan_Juan NSandoval NSanta_Fe NSocorro NTaos NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay 
NSan_Miguel NSierra NCatron NCurry NLea NTorrance NMetro_Region NNortheast_Region NNorthwest_Region NSoutheast_Region NSouthwest_Region;

sum NFemale NMale Total_Fall NAI_AN NHispanic NWhite NAsian_PI NBlack NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley NRio_Arriba 
NSan_Juan NSandoval NSanta_Fe NSocorro NTaos NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay NSan_Miguel NSierra 
NCatron NCurry NLea NTorrance NMetro_Region NNortheast_Region NNorthwest_Region NSoutheast_Region NSouthwest_Region;
run;


ods excel file="I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Software_Output\Fall\Fall_N_2022.xlsx";
proc print data=Fall_N sumlabel='Totals' noobs; 
var Age_cat NFemale NMale Total_Fall NAI_AN NHispanic NWhite NAsian_PI NBlack NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley 
NRio_Arriba NSan_Juan NSandoval NSanta_Fe NSocorro NTaos NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay 
NSan_Miguel NSierra NCatron NCurry NLea NTorrance NMetro_Region NNortheast_Region NNorthwest_Region NSoutheast_Region NSouthwest_Region;

sum NFemale NMale Total_Fall NAI_AN NHispanic NWhite NAsian_PI NBlack NBernalillo NDona_Ana NEddy NGrant NGuadalupe NMcKinley NRio_Arriba 
NSan_Juan NSandoval NSanta_Fe NSocorro NTaos NUnknown NValencia NChavez NCibola NColfax NLos_Alamos NLuna NOtero NQuay NSan_Miguel NSierra 
NCatron NCurry NLea NTorrance NMetro_Region NNortheast_Region NNorthwest_Region NSoutheast_Region NSouthwest_Region;
run;
ods excel close;



/******************************************************************/
/*MERGE ALL FALL COUNT DATA (Fall_N) WITH NM POPULATION DATA*/
/******************************************************************/
/*Import Fall Count Data that was Cleaned. You can also work directly with the Uncleaned Suicide_N data*/
/*Seven counties were added with 0 adult fall counts*/

proc import datafile= "I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Software_Output\Fall\Fall_N_2022_ed" 
                  out= Fall_N_2022
                  dbms= xlsx 
                  replace;
          getnames= yes;
run;

/*Import NM 2021 Population Data*/
proc import datafile= "I:\DATA_ANALYSIS\Data_NMPopulation_2021\AllPopData_2021_OlderAdults" 
                  out= Pop_2021
                  dbms= xlsx 
                  replace;
          getnames= yes;
run;

proc print data=Fall_N_2022; run;
proc print data=Pop_2021; run;

proc contents data=Fall_N; run;
proc contents data=Fall_N_2022; run;
proc contents data=Pop_2021; run;


/*MERGE SUICIDE COUNT DATA (Suicide_N) with NM POPULATION DATA*/
proc sort data = Fall_N_2022;
by Age_cat;
run;

proc sort data = Pop_2021;
by Age_cat;
run;

data Fall_Rates;
	merge Fall_N_2022 Pop_2021;
	by Age_cat;
run;

proc print data=Fall_Rates; run;
proc contents data=Fall_Rates; run;

/****************************************/
/*CALCULATE CRUDE AND AGE-ADJUSTED RATES*/
/****************************************/


/**************************************************************/
/**************************CRUDE RATES*************************/
/**************************************************************/
data Fall_Rates2;
	set Fall_Rates;
	
	/*Calculate the crude rate per 100000 population - i.e., number of death divided by pop multiplied by 100000*/
	Total_rate = (Total_Fall/NM_Tot_Pop)*100000;
	Female_rate = (NFemale/Female)*100000;
	Male_rate = (NMale/Male)*100000;
	AIAN_rate = (NAI_AN/AIAN)*100000;
	API_rate = (NAsian_PI/API)*100000;
	Black_rate = (NBlack /Black)*100000;
	Hispanic_rate = (NHispanic/Hispanic)*100000;
	White_rate = (NWhite/White)*100000;
	Bernalillo_rate = (NBernalillo/Bernalillo)*100000;
	Catron_rate = (NCatron/Catron)*100000;
	Chavez_rate = (NChavez/Chaves)*100000;
	Cibola_rate = (NCibola/Cibola)*100000;
	Colfax_rate = (NColfax/Colfax)*100000;
	Curry_rate = (NCurry/Curry)*100000;
	De_Baca_rate = (NDe_Baca/De_Baca)*100000;
	Dona_Ana_rate = (NDona_Ana/Dona_Ana)*100000;
	Eddy_rate = (NEddy/Eddy)*100000;
	Grant_rate = (NGrant/Grant)*100000;
	Guadalupe_rate = (NGuadalupe/Guadalupe)*100000;
	Harding_rate = (NHarding/Harding)*100000;
	Hidalgo_rate = (NHidalgo/Hidalgo)*100000;
	Lea_rate = (NLea/Lea)*100000;
	Lincoln_rate = (NLincoln/Lincoln)*100000;
	Los_Alamos_rate = (NLos_Alamos/Los_Alamos)*100000;
	Luna_rate = (NLuna/Luna)*100000;
	McKinley_rate = (NMcKinley/McKinley)*100000;
	Mora_rate = (NMora/Mora)*100000;
	Otero_rate = (NOtero/Otero)*100000;
	Quay_rate = (NQuay/Quay)*100000;
	Rio_Arriba_rate = (NRio_Arriba/Rio_Arriba)*100000;
	Roosevelt_rate = (NRoosevelt/Roosevelt)*100000;
	Sandoval_rate = (NSandoval/Sandoval)*100000;
	San_Juan_rate = (NSan_Juan/San_Juan)*100000;
	San_Miguel_rate = (NSan_Miguel/San_Miguel)*100000;
	Santa_Fe_rate = (NSanta_Fe/Santa_Fe)*100000;
	Sierra_rate = (NSierra/Sierra)*100000;
	Socorro_rate = (NSocorro/Socorro)*100000;
	Taos_rate = (NTaos/Taos)*100000;
	Torrance_rate = (NTorrance/Torrance)*100000;
	Union_rate = (NUnion/Union)*100000;
	Valencia_rate = (NValencia/Valencia)*100000;
	Metro_rate = (NMetro_Region/Metro)*100000;
	Northeast_rate = (NNortheast_Region/Northeast)*100000;
	Northwest_rate = (NNorthwest_Region/Northwest)*100000;
	Southeast_rate = (NSoutheast_Region/Southeast)*100000;
	Southwest_rate = (NSouthwest_Region/Southwest)*100000;
	
run;
/*14 observations and 144 variables*/


proc print data=Fall_Rates2; 
var Age_cat Total_rate Total_Fall NM_Tot_Pop;
run;

proc print data=Fall_Rates2; run;

ods excel file="I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Software_Output\Fall\Fall_Crude_Rates_2022.xlsx";
proc print data=Fall_Rates2;
var Age_cat Total_rate Female_rate Male_rate AIAN_rate API_rate Black_rate Hispanic_rate White_rate Bernalillo_rate Catron_rate Chavez_rate 
Cibola_rate Colfax_rate Curry_rate De_Baca_rate Dona_Ana_rate Eddy_rate Grant_rate Guadalupe_rate Harding_rate Hidalgo_rate Lea_rate 
Lincoln_rate Los_Alamos_rate Luna_rate McKinley_rate Mora_rate Otero_rate Quay_rate Rio_Arriba_rate Roosevelt_rate Sandoval_rate 
San_Juan_rate San_Miguel_rate Santa_Fe_rate Sierra_rate Socorro_rate Taos_rate Torrance_rate Union_rate Valencia_rate Metro_rate 
Northeast_rate Northwest_rate Southeast_rate Southwest_rate ;
run;
ods excel close;


/*********************************************************************/
/**************************AGE ADJUSTED RATES*************************/
/*****************************************+++++++*********************/
data Fall_Rates3;
	set Fall_Rates2;

	/*Calculate the age-adjusted rate per 100000 population - i.e., crude rate multiplied by 2000 standard pop weight*/
	Total_AArate = Total_rate*StandardPop_Wt;
	Female_AArate = Female_rate*StandardPop_Wt;
	Male_AArate = Male_rate*StandardPop_Wt;
	AIAN_AArate = AIAN_rate*StandardPop_Wt;
	API_AArate = API_rate*StandardPop_Wt;
	Black_AArate = Black_rate*StandardPop_Wt;
	Hispanic_AArate = Hispanic_rate*StandardPop_Wt;
	White_AArate = White_rate*StandardPop_Wt;
	Bernalillo_AArate = Bernalillo_rate*StandardPop_Wt; 
	Catron_AArate = Catron_rate*StandardPop_Wt;
	Chavez_AArate = Chavez_rate*StandardPop_Wt;
	Cibola_AArate = Cibola_rate*StandardPop_Wt;
	Colfax_AArate = Colfax_rate*StandardPop_Wt;
	Curry_AArate = Curry_rate*StandardPop_Wt;
	De_Baca_AArate = De_Baca_rate*StandardPop_Wt;
	Dona_Ana_AArate = Dona_Ana_rate*StandardPop_Wt;
	Eddy_AArate = Eddy_rate*StandardPop_Wt;
	Grant_AArate = Grant_rate*StandardPop_Wt;
	Guadalupe_AArate = Guadalupe_rate*StandardPop_Wt;
	Harding_AArate = Harding_rate*StandardPop_Wt;
	Hidalgo_AArate = Hidalgo_rate*StandardPop_Wt;
	Lea_AArate = Lea_rate*StandardPop_Wt;
	Lincoln_AArate = Lincoln_rate*StandardPop_Wt;
	Los_Alamos_AArate = Los_Alamos_rate*StandardPop_Wt;
	Luna_AArate = Luna_rate*StandardPop_Wt;
	McKinley_AArate = McKinley_rate*StandardPop_Wt;
	Mora_AArate = Mora_rate*StandardPop_Wt;
	Otero_AArate = Otero_rate*StandardPop_Wt;
	Quay_AArate = Quay_rate*StandardPop_Wt;
	Rio_Arriba_AArate = Rio_Arriba_rate*StandardPop_Wt; 
	Roosevelt_AArate = Roosevelt_rate*StandardPop_Wt;
	Sandoval_AArate = Sandoval_rate*StandardPop_Wt;
	San_Juan_AArate = San_Juan_rate*StandardPop_Wt;
	San_Miguel_AArate = San_Miguel_rate*StandardPop_Wt;
	Santa_Fe_AArate = Santa_Fe_rate*StandardPop_Wt;
	Sierra_AArate = Sierra_rate*StandardPop_Wt;
	Socorro_AArate = Socorro_rate*StandardPop_Wt;
	Taos_AArate = Taos_rate*StandardPop_Wt;
	Torrance_AArate = Torrance_rate*StandardPop_Wt;
	Union_AArate = Union_rate*StandardPop_Wt;
	Valencia_AArate = Valencia_rate*StandardPop_Wt;
	Metro_AArate = Metro_rate*StandardPop_Wt;
	Northeast_AArate = Northeast_rate*StandardPop_Wt;
	Northwest_AArate = Northwest_rate*StandardPop_Wt;
	Southeast_AArate = Southeast_rate*StandardPop_Wt;
	Southwest_AArate = Southwest_rate*StandardPop_Wt;
		
	/*Delete the last row, TOTAL. Reason: Age-adjusted rate totals are computed by adding all rows not by multiplication with crude rates*/
	if Age_cat = "TOTAL" then delete;
	
run;
/*13 observations and 190 variables*/

proc print data=Fall_Rates3; 
var Age_cat StandardPop_Wt Total_rate Total_AArate;
run;

proc print data=Fall_Rates3; run;

/*Calcualte the Total Age-Adjusted Rates for each Variables using Proc Print*/
/*Add additional row, TOTAL, that is the sum of all rows*/
proc print data=Fall_Rates3 sumlabel='Totals' noobs; 
var Age_cat Total_AArate Female_AArate Male_AArate AIAN_AArate API_AArate Black_AArate Hispanic_AArate White_AArate 
Bernalillo_AArate Catron_AArate Chavez_AArate Cibola_AArate Colfax_AArate Curry_AArate De_Baca_AArate Dona_Ana_AArate 
Eddy_AArate Grant_AArate Guadalupe_AArate Harding_AArate Hidalgo_AArate Lea_AArate Lincoln_AArate Los_Alamos_AArate 
Luna_AArate McKinley_AArate Mora_AArate Otero_AArate Quay_AArate Rio_Arriba_AArate Roosevelt_AArate Sandoval_AArate 
San_Juan_AArate San_Miguel_AArate Santa_Fe_AArate Sierra_AArate Socorro_AArate Taos_AArate Torrance_AArate Union_AArate 
Valencia_AArate Metro_AArate Northeast_AArate Northwest_AArate Southeast_AArate Southwest_AArate;

sum Total_AArate Female_AArate Male_AArate AIAN_AArate API_AArate Black_AArate Hispanic_AArate White_AArate 
Bernalillo_AArate Catron_AArate Chavez_AArate Cibola_AArate Colfax_AArate Curry_AArate De_Baca_AArate Dona_Ana_AArate 
Eddy_AArate Grant_AArate Guadalupe_AArate Harding_AArate Hidalgo_AArate Lea_AArate Lincoln_AArate Los_Alamos_AArate 
Luna_AArate McKinley_AArate Mora_AArate Otero_AArate Quay_AArate Rio_Arriba_AArate Roosevelt_AArate Sandoval_AArate 
San_Juan_AArate San_Miguel_AArate Santa_Fe_AArate Sierra_AArate Socorro_AArate Taos_AArate Torrance_AArate Union_AArate 
Valencia_AArate Metro_AArate Northeast_AArate Northwest_AArate Southeast_AArate Southwest_AArate;
run;


/*Export Age-Adjusted Rates to an Excel File*/
ods excel file="I:\DATA_ANALYSIS\Data_Analysis_2022DeathData\Software_Output\Fall\Fall_Rates_2022.xlsx";
proc print data=Fall_Rates3 sumlabel='Totals' noobs; 
var Age_cat Total_AArate Female_AArate Male_AArate AIAN_AArate API_AArate Black_AArate Hispanic_AArate White_AArate 
Bernalillo_AArate Catron_AArate Chavez_AArate Cibola_AArate Colfax_AArate Curry_AArate De_Baca_AArate Dona_Ana_AArate 
Eddy_AArate Grant_AArate Guadalupe_AArate Harding_AArate Hidalgo_AArate Lea_AArate Lincoln_AArate Los_Alamos_AArate 
Luna_AArate McKinley_AArate Mora_AArate Otero_AArate Quay_AArate Rio_Arriba_AArate Roosevelt_AArate Sandoval_AArate 
San_Juan_AArate San_Miguel_AArate Santa_Fe_AArate Sierra_AArate Socorro_AArate Taos_AArate Torrance_AArate Union_AArate 
Valencia_AArate Metro_AArate Northeast_AArate Northwest_AArate Southeast_AArate Southwest_AArate;

sum Total_AArate Female_AArate Male_AArate AIAN_AArate API_AArate Black_AArate Hispanic_AArate White_AArate 
Bernalillo_AArate Catron_AArate Chavez_AArate Cibola_AArate Colfax_AArate Curry_AArate De_Baca_AArate Dona_Ana_AArate 
Eddy_AArate Grant_AArate Guadalupe_AArate Harding_AArate Hidalgo_AArate Lea_AArate Lincoln_AArate Los_Alamos_AArate 
Luna_AArate McKinley_AArate Mora_AArate Otero_AArate Quay_AArate Rio_Arriba_AArate Roosevelt_AArate Sandoval_AArate 
San_Juan_AArate San_Miguel_AArate Santa_Fe_AArate Sierra_AArate Socorro_AArate Taos_AArate Torrance_AArate Union_AArate 
Valencia_AArate Metro_AArate Northeast_AArate Northwest_AArate Southeast_AArate Southwest_AArate;
run;
ods excel close;



/*
VARIABLE NAMES for Suicide Counts and Population Numbers

Total_Suicide NFemale NMale NAI_AN NBlack NHispanic NWhite NAsian_PI NOther NUnknown 

NBernalillo NCatron NChavez NCibola NColfax NCurry NDe_Baca NDona_Ana NEddy NGrant NGuadalupe NHarding NHidalgo NLea NLincoln 
NLos_Alamos NLuna NMcKinley NMora NOtero NQuay NRio_Arriba NRoosevelt NSandoval NSan_Juan NSan_Miguel NSanta_Fe NSierra NSocorro 
NTaos NUnion NTorrance NValencia
 
NMetro_Region NNortheast_Region NSoutheast_Region NSouthwest_Region NNorthwest_Region 

StandardPop_2000 StandardPop_Wt
 
NM_Tot_Pop Male Female White Hispanic Black API AIAN 

Bernalillo Catron Chaves Cibola Colfax Curry De_Baca Dona_Ana Eddy Grant Guadalupe Harding Hidalgo Lea Lincoln 
Los_Alamos Luna McKinley Mora Otero Quay Rio_Arriba Roosevelt Sandoval San_Juan San_Miguel Santa_Fe Sierra Socorro 
Taos Torrance Union Valencia 

Northwest Northeast Southwest Southeast Metro 
*/







PROC FORMAT;
	VALUE Education	
				1 = '8th grade or less'
				2 = '9th-12th grade - no dip'
				3 = 'High school Grad/GED completed'
				4 = 'Some college credit but no degree'
				5 = 'Associate degree'
				6 = 'Bachelors degree'
				7 = 'Masters degree'
				8 = 'Doctorate or Prof degree'
				9 = 'Unknown';
RUN;
