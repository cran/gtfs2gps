## ---- eval = FALSE------------------------------------------------------------
#  devtools::install_github("ipeaGIT/gtfs2gps")

## -----------------------------------------------------------------------------
library("data.table")
library("gtfs2gps")
sao <- read_gtfs(system.file("extdata/saopaulo.zip", package ="gtfs2gps"))
names(sao)
sao$trips

## -----------------------------------------------------------------------------
library(magrittr)
object.size(sao) %>% format(units = "Kb")
sao_small <- gtfs2gps::filter_by_shape_id(sao, c(51338, 51956, 51657))
object.size(sao_small) %>% format(units = "Kb")

## ----sao_small_shapes_sf, message = FALSE-------------------------------------
sao_small_shapes_sf <- gtfs2gps::gtfs_shapes_as_sf(sao_small)
sao_small_stops_sf <- gtfs2gps::gtfs_stops_as_sf(sao_small)
plot(sf::st_geometry(sao_small_shapes_sf))
plot(sf::st_geometry(sao_small_stops_sf), pch = 20, col = "red", add = TRUE)
box()

## ---- message = FALSE---------------------------------------------------------
write_gtfs(sao_small, "sao_small.zip")

## ---- message = FALSE---------------------------------------------------------
  sao_gps <- gtfs2gps("sao_small.zip", progress = FALSE, parallel = FALSE, spatial_resolution = 15)
  head(sao_gps)

## ---- message = FALSE---------------------------------------------------------
  shapes_sf <- gps_as_sf(sao_gps)
  sao_gps60 <- sao_gps[1:100, ]
  sao_gps60_sf <- gps_as_sf(sao_gps60)
  plot(sf::st_geometry(sao_gps60_sf), pch = 20)
  plot(sf::st_geometry(sao_small_shapes_sf), col = "blue", add = TRUE)
  box()

## ---- message = FALSE---------------------------------------------------------
poa <- system.file("extdata/poa.zip", package ="gtfs2gps")
poa_gps <- gtfs2gps(poa, progress = FALSE, parallel = FALSE, spatial_resolution = 15)
poa_gps_sf <- gps_as_sf(poa_gps)
poa_sf <- read_gtfs(poa) %>% gtfs_shapes_as_sf()
plot(sf::st_geometry(poa_gps_sf[1:200,]))
plot(sf::st_geometry(poa_sf), col = "blue", add = TRUE)
box()

## ----speed, echo = FALSE, message = FALSE-------------------------------------
knitr::include_graphics("https://github.com/ipeaGIT/gtfs2gps/blob/master/man/figures/speed.PNG")

