## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("gtfs2gps")

## -----------------------------------------------------------------------------
library("gtfs2gps")
poa <- read_gtfs(system.file("extdata/poa.zip", package ="gtfs2gps"))
names(poa)
head(poa$trips)

## -----------------------------------------------------------------------------
object.size(poa) |> format(units = "Kb")
poa_small <- gtfstools::filter_by_shape_id(poa, c("T2-1", "A141-1"))
object.size(poa_small) |> format(units = "Kb")

## ----poa_small_shapes_sf, message = FALSE-------------------------------------
poa_small_shapes_sf <- gtfs2gps::gtfs_shapes_as_sf(poa_small)
poa_small_stops_sf <- gtfs2gps::gtfs_stops_as_sf(poa_small)
plot(sf::st_geometry(poa_small_shapes_sf))
plot(sf::st_geometry(poa_small_stops_sf), pch = 20, col = "red", add = TRUE)
box()

## ----message = FALSE----------------------------------------------------------
temp_gtfs <- tempfile(pattern = 'poa_small', fileext = '.zip')

gtfs2gps::write_gtfs(poa_small, temp_gtfs)

## ----message = FALSE----------------------------------------------------------
poa_gps <- gtfs2gps(temp_gtfs, spatial_resolution = 100)
head(poa_gps)

## ----message = FALSE----------------------------------------------------------
poa_gps60 <- poa_gps[1:100, ]

# points
poa_gps60_sfpoints <- gps_as_sfpoints(poa_gps60)

# linestring
poa_gps60_sflinestring <- gps_as_sflinestring(poa_gps60)

# plot
plot(sf::st_geometry(poa_gps60_sfpoints), pch = 20)
plot(sf::st_geometry(poa_gps60_sflinestring), col = "blue", add = TRUE)
box()

## ----message = FALSE----------------------------------------------------------
poa <- system.file("extdata/poa.zip", package ="gtfs2gps")

poa_gps <- gtfs2gps(poa, spatial_resolution = 50)

poa_gps_sflinestrig <- gps_as_sfpoints(poa_gps)

plot(sf::st_geometry(poa_gps_sflinestrig[1:200,]))

box()

## ----equation, echo = FALSE, message = FALSE----------------------------------
knitr::include_graphics("https://github.com/ipeaGIT/gtfs2gps/blob/master/man/figures/equation1.png?raw=true")

## ----speed, echo = FALSE, message = FALSE-------------------------------------
knitr::include_graphics("https://github.com/ipeaGIT/gtfs2gps/blob/master/man/figures/speed.PNG?raw=true")

