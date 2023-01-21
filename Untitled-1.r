# Package "rnoaa" for getting 'NOAA' Weather Data from R
library(rnoaa)

# create a data frame for Lviv latitude and longitude
lat_lon_lviv <- data.frame(id = "pw",lat = 49.842957, lon = 24.031111)

# find 10 closest monitors to Lviv
mon_near_lviv <- meteo_nearby_stations(
  lat_lon_lviv, 
  lat_colname = "lat", 
  lon_colname = "lon",
  var = "PRCP",
  year_min = 2019,
  year_max = 2020,
  limit = 10,
)

# what the station should be chosen
mon_near_lviv

# extract daily precipitation data for the first location (Lviv)
lviv_prcp_dat <- 
meteo_pull_monitors(
 monitors = mon_near_lviv$pw$id[1],
 date_min = "2021-01-01",
  date_max = "2021-12-31",
  var = "PRCP"
  )

# View the results
View(lviv_prcp_dat)

# Replace NA to 0
lviv_prcp_dat[is.na(lviv_prcp_dat)] <- 0

# As PRCP: Precipitation is in tenths of millimeters, we have to convert PRCP in mm
lviv_prcp_dat$prcp <- 0.1*(lviv_prcp_dat$prcp)

# to see the precipitation per year
sum <- sum(lviv_prcp_dat$prcp)
sum