SELECT * 
FROM mmsa_icu_beds
;

SELECT * 
FROM cdc_deaths_by_state
ORDER BY state
;


SELECT state, date_updated, tot_cases, tot_deaths
FROM cdc_deaths_by_state
WHERE date_updated = "01/05/2023"
;

CREATE TABLE cdc_deaths_jan_2023 AS
SELECT
  state,
  date_updated,
  tot_cases,
  tot_deaths
FROM
  cdc_deaths_by_state
WHERE
  date_updated = '01/05/2023';

SELECT * 
FROM gun_ownership_by_state_2025
;

CREATE TABLE state_mapping (
  abbreviation VARCHAR(2) PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO state_mapping (abbreviation, full_name) VALUES
('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');

SELECT * 
FROM state_mapping
;


CREATE TABLE gun_ownership_with_mapping AS
SELECT *
FROM
  gun_ownership_by_state_2025 AS gobs
JOIN
  state_mapping AS sm
  ON gobs.state = sm.full_name;
  
SELECT *
FROM gun_ownership_with_mapping
;

SELECT *
FROM cdc_deaths_jan_2023;

SELECT *
FROM gun_ownership_with_mapping as gowm
JOIN 
	cdc_deaths_jan_2023 as cd
    ON gowm.abbreviation = cd.state
;

CREATE TABLE gun_covid_table AS
SELECT 
GunOwnership_PercentageOfHouseholdsThatOwnGuns_pct_2022,
GunOwnership_NumOfGunLicenses_num_2022,
abbreviation,
full_name,
date_updated,
tot_cases,
tot_deaths
FROM gun_ownership_with_mapping as gowm
JOIN 
	cdc_deaths_jan_2023 as cd
    ON gowm.abbreviation = cd.state
;

SELECT *
FROM gun_covid_table
;
	
SELECT *
FROM all_data
;

CREATE TABLE commuter_data
SELECT
    `State`,
    `Year`,
    MAX(CASE WHEN `Mode` = 'Bicycle' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Bicycle`,
    MAX(CASE WHEN `Mode` = 'Walked' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Walked`,
    MAX(CASE WHEN `Mode` = 'Carpool' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Carpool`,
    MAX(CASE WHEN `Mode` = 'Drove alone' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Drove_alone`,
    MAX(CASE WHEN `Mode` = 'Public transportation' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Public_transportation`,
    MAX(CASE WHEN `Mode` = 'Taxi, motorcycle, or other' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Taxi_motorcycle_or_other`,
    MAX(CASE WHEN `Mode` = 'Worked at home' THEN CAST(`Commute mode share (percent)` AS FLOAT) END) AS `Worked_at_home`
FROM
    all_data
GROUP BY
    `State`,
    `Year`
ORDER BY
    `State`,
    `Year`;


CREATE TABLE gun_covid_commute
SELECT *
FROM gun_covid_table as gvt
JOIN 
	commuter_data as cd
    ON gvt.full_name = cd.state
;

CREATE TABLE gcc
SELECT * 
FROM gun_covid_commute
WHERE year = 2023;

SELECT * 
FROM gcc
;

SELECT * 
FROM raw_data4
;


SELECT *
FROM gcc
JOIN 
	raw_data4 as rd4
    ON gcc.State = rd4.FRLocation
;

SELECT *
FROM raw_data4 as rd4
JOIN 
	gun_covid_commute as gcc
    ON rd4.FRLocation = gcc.full_name
;


SELECT *
FROM gun_covid_commute_demographics
;

CREATE TABLE final_table_draft
SELECT *
FROM
    raw_data4 AS rd4
JOIN
    gun_covid_commute AS gcc
    ON TRIM(UPPER(rd4.FRLocation)) = TRIM(UPPER(gcc.full_name));
    

CREATE TABLE final2
SELECT
    rd4.*,
    gcc.*,
    CASE TRIM(UPPER(rd4.FRLocation))
        WHEN 'ALABAMA' THEN 'Republican'
        WHEN 'ALASKA' THEN 'Republican'
        WHEN 'ARIZONA' THEN 'Republican'
        WHEN 'ARKANSAS' THEN 'Republican'
        WHEN 'CALIFORNIA' THEN 'Democrat'
        WHEN 'COLORADO' THEN 'Democrat'
        WHEN 'CONNECTICUT' THEN 'Democrat'
        WHEN 'DELAWARE' THEN 'Democrat'
        WHEN 'DISTRICT OF COLUMBIA' THEN 'Democrat'
        WHEN 'FLORIDA' THEN 'Republican'
        WHEN 'GEORGIA' THEN 'Republican'
        WHEN 'HAWAII' THEN 'Democrat'
        WHEN 'IDAHO' THEN 'Republican'
        WHEN 'ILLINOIS' THEN 'Democrat'
        WHEN 'INDIANA' THEN 'Republican'
        WHEN 'IOWA' THEN 'Republican'
        WHEN 'KANSAS' THEN 'Republican'
        WHEN 'KENTUCKY' THEN 'Republican'
        WHEN 'LOUISIANA' THEN 'Republican'
        WHEN 'MAINE' THEN 'Democrat'
        WHEN 'MARYLAND' THEN 'Democrat'
        WHEN 'MASSACHUSETTS' THEN 'Democrat'
        WHEN 'MICHIGAN' THEN 'Republican'
        WHEN 'MINNESOTA' THEN 'Democrat'
        WHEN 'MISSISSIPPI' THEN 'Republican'
        WHEN 'MISSOURI' THEN 'Republican'
        WHEN 'MONTANA' THEN 'Republican'
        WHEN 'NEBRASKA' THEN 'Republican'
        WHEN 'NEVADA' THEN 'Democrat'
        WHEN 'NEW HAMPSHIRE' THEN 'Democrat'
        WHEN 'NEW JERSEY' THEN 'Democrat'
        WHEN 'NEW MEXICO' THEN 'Democrat'
        WHEN 'NEW YORK' THEN 'Democrat'
        WHEN 'NORTH CAROLINA' THEN 'Republican'
        WHEN 'NORTH DAKOTA' THEN 'Republican'
        WHEN 'OHIO' THEN 'Republican'
        WHEN 'OKLAHOMA' THEN 'Republican'
        WHEN 'OREGON' THEN 'Democrat'
        WHEN 'PENNSYLVANIA' THEN 'Republican'
        WHEN 'RHODE ISLAND' THEN 'Democrat'
        WHEN 'SOUTH CAROLINA' THEN 'Republican'
        WHEN 'SOUTH DAKOTA' THEN 'Republican'
        WHEN 'TENNESSEE' THEN 'Republican'
        WHEN 'TEXAS' THEN 'Republican'
        WHEN 'UTAH' THEN 'Republican'
        WHEN 'VERMONT' THEN 'Democrat'
        WHEN 'VIRGINIA' THEN 'Democrat'
        WHEN 'WASHINGTON' THEN 'Democrat'
        WHEN 'WEST VIRGINIA' THEN 'Republican'
        WHEN 'WISCONSIN' THEN 'Republican'
        WHEN 'WYOMING' THEN 'Republican'
        ELSE 'N/A'
    END AS Election_2016_Winner,
    CASE TRIM(UPPER(rd4.FRLocation))
        WHEN 'ALABAMA' THEN 'Republican'
        WHEN 'ALASKA' THEN 'Republican'
        WHEN 'ARIZONA' THEN 'Democrat'
        WHEN 'ARKANSAS' THEN 'Republican'
        WHEN 'CALIFORNIA' THEN 'Democrat'
        WHEN 'COLORADO' THEN 'Democrat'
        WHEN 'CONNECTICUT' THEN 'Democrat'
        WHEN 'DELAWARE' THEN 'Democrat'
        WHEN 'DISTRICT OF COLUMBIA' THEN 'Democrat'
        WHEN 'FLORIDA' THEN 'Republican'
        WHEN 'GEORGIA' THEN 'Democrat'
        WHEN 'HAWAII' THEN 'Democrat'
        WHEN 'IDAHO' THEN 'Republican'
        WHEN 'ILLINOIS' THEN 'Democrat'
        WHEN 'INDIANA' THEN 'Republican'
        WHEN 'IOWA' THEN 'Republican'
        WHEN 'KANSAS' THEN 'Republican'
        WHEN 'KENTUCKY' THEN 'Republican'
        WHEN 'LOUISIANA' THEN 'Republican'
        WHEN 'MAINE' THEN 'Democrat'
        WHEN 'MARYLAND' THEN 'Democrat'
        WHEN 'MASSACHUSETTS' THEN 'Democrat'
        WHEN 'MICHIGAN' THEN 'Democrat'
        WHEN 'MINNESOTA' THEN 'Democrat'
        WHEN 'MISSISSIPPI' THEN 'Republican'
        WHEN 'MISSOURI' THEN 'Republican'
        WHEN 'MONTANA' THEN 'Republican'
        WHEN 'NEBRASKA' THEN 'Republican'
        WHEN 'NEVADA' THEN 'Democrat'
        WHEN 'NEW HAMPSHIRE' THEN 'Democrat'
        WHEN 'NEW JERSEY' THEN 'Democrat'
        WHEN 'NEW MEXICO' THEN 'Democrat'
        WHEN 'NEW YORK' THEN 'Democrat'
        WHEN 'NORTH CAROLINA' THEN 'Republican'
        WHEN 'NORTH DAKOTA' THEN 'Republican'
        WHEN 'OHIO' THEN 'Republican'
        WHEN 'OKLAHOMA' THEN 'Republican'
        WHEN 'OREGON' THEN 'Democrat'
        WHEN 'PENNSYLVANIA' THEN 'Democrat'
        WHEN 'RHODE ISLAND' THEN 'Democrat'
        WHEN 'SOUTH CAROLINA' THEN 'Republican'
        WHEN 'SOUTH DAKOTA' THEN 'Republican'
        WHEN 'TENNESSEE' THEN 'Republican'
        WHEN 'TEXAS' THEN 'Republican'
        WHEN 'UTAH' THEN 'Republican'
        WHEN 'VERMONT' THEN 'Democrat'
        WHEN 'VIRGINIA' THEN 'Democrat'
        WHEN 'WASHINGTON' THEN 'Democrat'
        WHEN 'WEST VIRGINIA' THEN 'Republican'
        WHEN 'WISCONSIN' THEN 'Democrat'
        WHEN 'WYOMING' THEN 'Republican'
        ELSE 'N/A'
    END AS Election_2020_Winner,
    CASE TRIM(UPPER(rd4.FRLocation))
        WHEN 'ALABAMA' THEN 'Republican'
        WHEN 'ALASKA' THEN 'Republican'
        WHEN 'ARIZONA' THEN 'Republican'
        WHEN 'ARKANSAS' THEN 'Republican'
        WHEN 'CALIFORNIA' THEN 'Democrat'
        WHEN 'COLORADO' THEN 'Democrat'
        WHEN 'CONNECTICUT' THEN 'Democrat'
        WHEN 'DELAWARE' THEN 'Democrat'
        WHEN 'DISTRICT OF COLUMBIA' THEN 'Democrat'
        WHEN 'FLORIDA' THEN 'Republican'
        WHEN 'GEORGIA' THEN 'Republican'
        WHEN 'HAWAII' THEN 'Democrat'
        WHEN 'IDAHO' THEN 'Republican'
        WHEN 'ILLINOIS' THEN 'Democrat'
        WHEN 'INDIANA' THEN 'Republican'
        WHEN 'IOWA' THEN 'Republican'
        WHEN 'KANSAS' THEN 'Republican'
        WHEN 'KENTUCKY' THEN 'Republican'
        WHEN 'LOUISIANA' THEN 'Republican'
        WHEN 'MAINE' THEN 'Democrat'
        WHEN 'MARYLAND' THEN 'Democrat'
        WHEN 'MASSACHUSETTS' THEN 'Democrat'
        WHEN 'MICHIGAN' THEN 'Republican'
        WHEN 'MINNESOTA' THEN 'Democrat'
        WHEN 'MISSISSIPPI' THEN 'Republican'
        WHEN 'MISSOURI' THEN 'Republican'
        WHEN 'MONTANA' THEN 'Republican'
        WHEN 'NEBRASKA' THEN 'Republican'
        WHEN 'NEVADA' THEN 'Republican'
        WHEN 'NEW HAMPSHIRE' THEN 'Democrat'
        WHEN 'NEW JERSEY' THEN 'Democrat'
        WHEN 'NEW MEXICO' THEN 'Democrat'
        WHEN 'NEW YORK' THEN 'Democrat'
        WHEN 'NORTH CAROLINA' THEN 'Republican'
        WHEN 'NORTH DAKOTA' THEN 'Republican'
        WHEN 'OHIO' THEN 'Republican'
        WHEN 'OKLAHOMA' THEN 'Republican'
        WHEN 'OREGON' THEN 'Democrat'
        WHEN 'PENNSYLVANIA' THEN 'Republican'
        WHEN 'RHODE ISLAND' THEN 'Democrat'
        WHEN 'SOUTH CAROLINA' THEN 'Republican'
        WHEN 'SOUTH DAKOTA' THEN 'Republican'
        WHEN 'TENNESSEE' THEN 'Republican'
        WHEN 'TEXAS' THEN 'Republican'
        WHEN 'UTAH' THEN 'Republican'
        WHEN 'VERMONT' THEN 'Democrat'
        WHEN 'VIRGINIA' THEN 'Democrat'
        WHEN 'WASHINGTON' THEN 'Democrat'
        WHEN 'WEST VIRGINIA' THEN 'Republican'
        WHEN 'WISCONSIN' THEN 'Republican'
        WHEN 'WYOMING' THEN 'Republican'
        ELSE 'N/A'
    END AS Election_2024_Winner
FROM
    raw_data4 AS rd4
JOIN
    gun_covid_commute AS gcc
    ON TRIM(UPPER(rd4.FRLocation)) = TRIM(UPPER(gcc.full_name));

SELECT *
FROM final2
WHERE year = 2023
;

    
SELECT *
FROM final_table
;

ALTER TABLE final2
ADD COLUMN Median_Household_Income INT;

UPDATE final2
SET Median_Household_Income = CASE TRIM(UPPER(FRLocation))
    WHEN 'MARYLAND' THEN 101652
    WHEN 'MASSACHUSETTS' THEN 101341
    WHEN 'NEW JERSEY' THEN 101050
    WHEN 'NEW HAMPSHIRE' THEN 95628
    WHEN 'CALIFORNIA' THEN 96334
    WHEN 'HAWAII' THEN 98317
    WHEN 'WASHINGTON' THEN 94952
    WHEN 'CONNECTICUT' THEN 93760
    WHEN 'COLORADO' THEN 92470
    WHEN 'VIRGINIA' THEN 90974
    WHEN 'ALASKA' THEN 89336
    WHEN 'MINNESOTA' THEN 87556
    WHEN 'UTAH' THEN 91750
    WHEN 'RHODE ISLAND' THEN 86372
    WHEN 'NEW YORK' THEN 84578
    WHEN 'DELAWARE' THEN 82855
    WHEN 'ILLINOIS' THEN 81702
    WHEN 'OREGON' THEN 80426
    WHEN 'VERMONT' THEN 78024
    WHEN 'ARIZONA' THEN 76872
    WHEN 'TEXAS' THEN 76292
    WHEN 'PENNSYLVANIA' THEN 76081
    WHEN 'NORTH DAKOTA' THEN 75949
    WHEN 'WISCONSIN' THEN 75670
    WHEN 'NEVADA' THEN 75561
    WHEN 'NEBRASKA' THEN 74985
    WHEN 'WYOMING' THEN 74815
    WHEN 'GEORGIA' THEN 74664
    WHEN 'IDAHO' THEN 74636
    WHEN 'IOWA' THEN 73147
    WHEN 'KANSAS' THEN 72639
    WHEN 'SOUTH DAKOTA' THEN 72421
    WHEN 'MAINE' THEN 71773
    WHEN 'FLORIDA' THEN 71711
    WHEN 'MICHIGAN' THEN 71149
    WHEN 'INDIANA' THEN 70051
    WHEN 'MONTANA' THEN 69922
    WHEN 'NORTH CAROLINA' THEN 69904
    WHEN 'OHIO' THEN 69680
    WHEN 'MISSOURI' THEN 68920
    WHEN 'TENNESSEE' THEN 67097
    WHEN 'SOUTH CAROLINA' THEN 66818
    WHEN 'OKLAHOMA' THEN 63603
    WHEN 'KENTUCKY' THEN 62417
    WHEN 'NEW MEXICO' THEN 62125
    WHEN 'ALABAMA' THEN 62027
    WHEN 'LOUISIANA' THEN 60023
    WHEN 'ARKANSAS' THEN 58773
    WHEN 'WEST VIRGINIA' THEN 57917
    WHEN 'MISSISSIPPI' THEN 54915
    WHEN 'DISTRICT OF COLUMBIA' THEN 106287
    ELSE 0
END;

SELECT *
FROM final2
;

ALTER TABLE final2
ADD COLUMN unemploment_rate INT;

UPDATE final2
SET unemploment_rate = CASE TRIM(UPPER(FRLocation))
        WHEN 'SOUTH DAKOTA' THEN 1.9
        WHEN 'NORTH DAKOTA' THEN 2.5
        WHEN 'VERMONT' THEN 2.5
        WHEN 'HAWAII' THEN 2.7
        WHEN 'ALABAMA' THEN 2.9
        WHEN 'MONTANA' THEN 2.9
        WHEN 'NEBRASKA' THEN 3.0
        WHEN 'NEW HAMPSHIRE' THEN 3.0
        WHEN 'OKLAHOMA' THEN 3.1
        WHEN 'WISCONSIN' THEN 3.1
        WHEN 'MAINE' THEN 3.2
        WHEN 'WYOMING' THEN 3.2
        WHEN 'UTAH' THEN 3.3
        WHEN 'GEORGIA' THEN 3.4
        WHEN 'INDIANA' THEN 3.6
        WHEN 'MARYLAND' THEN 3.6
        WHEN 'MINNESOTA' THEN 3.6
        WHEN 'TENNESSEE' THEN 3.6
        WHEN 'VIRGINIA' THEN 3.6
        WHEN 'IDAHO' THEN 3.7
        WHEN 'NORTH CAROLINA' THEN 3.7
        WHEN 'ARKANSAS' THEN 3.8
        WHEN 'CONNECTICUT' THEN 3.8
        WHEN 'FLORIDA' THEN 3.8
        WHEN 'IOWA' THEN 3.8
        WHEN 'KANSAS' THEN 3.8
        WHEN 'WEST VIRGINIA' THEN 3.8
        WHEN 'MISSISSIPPI' THEN 3.9
        WHEN 'NEW YORK' THEN 4.0
        WHEN 'PENNSYLVANIA' THEN 4.0
        WHEN 'ARIZONA' THEN 4.1
        WHEN 'MISSOURI' THEN 4.1
        WHEN 'NEW MEXICO' THEN 4.1
        WHEN 'TEXAS' THEN 4.1
        WHEN 'COLORADO' THEN 4.2
        WHEN 'DELAWARE' THEN 4.3
        WHEN 'SOUTH CAROLINA' THEN 4.3
        WHEN 'ILLINOIS' THEN 4.4
        WHEN 'LOUISIANA' THEN 4.4
        WHEN 'WASHINGTON' THEN 4.5
        WHEN 'RHODE ISLAND' THEN 4.6
        WHEN 'ALASKA' THEN 4.7
        WHEN 'KENTUCKY' THEN 4.7
        WHEN 'MASSACHUSETTS' THEN 4.8
        WHEN 'NEW JERSEY' THEN 5.0
        WHEN 'OHIO' THEN 5.0
        WHEN 'OREGON' THEN 5.0
        WHEN 'MICHIGAN' THEN 5.2
        WHEN 'NEVADA' THEN 5.3
        WHEN 'CALIFORNIA' THEN 5.5
        WHEN 'DISTRICT OF COLUMBIA' THEN 6.0
        ELSE 0.0
END;

CREATE TABLE final_table_selection
SELECT *
FROM final2
WHERE year = 2023
;

SELECT *
FROM final_table_selection
;

