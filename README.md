
<!-- README.md is generated from README.Rmd. Please edit that file -->

# earthquaker

<!-- badges: start -->

[![R-CMD-check](https://github.com/andypicke/earthquaker/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/earthquaker/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of earthquaker is to provide R functions to retrieve earthquake
data from the [USGS API](https://earthquake.usgs.gov/fdsnws/event/1/)

## Installation

You can install the development version of earthquaker from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andypicke/earthquaker")
```

## Examples

### Get dataframe of earthquakes for a 2 day period:

``` r

library(earthquaker)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

``` r

df <- get_earthquakes(starttime = "2024-06-25", endtime = "2024-06-27")

head(df)
#> # A tibble: 6 × 22
#>   time                latitude longitude depth   mag magType   nst   gap    dmin
#>   <dttm>                 <dbl>     <dbl> <dbl> <dbl> <chr>   <dbl> <dbl>   <dbl>
#> 1 2024-06-26 23:57:56     63.3    -150.   2     2.1  ml         NA    NA NA     
#> 2 2024-06-26 23:55:06     36.9    -122.   7.05  1.33 md         32    52  0.0181
#> 3 2024-06-26 23:48:41     53.9    -167.   9.73  1.45 ml         11   112  0.0831
#> 4 2024-06-26 23:37:26     63.3    -150.   4     1.2  ml         NA    NA NA     
#> 5 2024-06-26 23:31:13     28.7     -98.9  8.16  1.6  ml         16    67  0.2   
#> 6 2024-06-26 23:30:54     53.9    -167.   8.82  1    ml         10   116  0.0867
#> # ℹ 13 more variables: rms <dbl>, net <chr>, id <chr>, updated <dttm>,
#> #   place <chr>, type <chr>, horizontalError <dbl>, depthError <dbl>,
#> #   magError <dbl>, magNst <dbl>, status <chr>, locationSource <chr>,
#> #   magSource <chr>
```

### Get earthquakes since 2020 with *orange* [PAGER](https://earthquake.usgs.gov/data/pager/) alert statuses:

``` r

df <- get_earthquakes(starttime = "2020-01-01", alert_level = "orange")

head(df)
#> # A tibble: 6 × 22
#>   time                latitude longitude depth   mag magType   nst   gap   dmin
#>   <dttm>                 <dbl>     <dbl> <dbl> <dbl> <chr>   <dbl> <dbl>  <dbl>
#> 1 2023-10-15 03:36:00    34.7       62.1   9     6.3 mww       125    21 5.71  
#> 2 2023-10-07 07:12:49    34.5       61.9   8     6.3 mww       244    43 5.90  
#> 3 2023-10-07 06:41:03    34.6       61.9  14     6.3 mww       279    43 5.87  
#> 4 2023-08-17 17:17:17     4.26     -73.5  10     5.6 mww       101    77 0.982 
#> 5 2023-03-24 03:16:56    38.5       44.9  11     5.6 mww       101    40 1.18  
#> 6 2022-12-20 10:34:24    40.5     -124.   17.9   6.4 mw         38   214 0.0818
#> # ℹ 13 more variables: rms <dbl>, net <chr>, id <chr>, updated <dttm>,
#> #   place <chr>, type <chr>, horizontalError <dbl>, depthError <dbl>,
#> #   magError <dbl>, magNst <dbl>, status <chr>, locationSource <chr>,
#> #   magSource <chr>
```

### Get all earthquakes in 2024 with magnitudes greater than 5:

``` r

df <- get_earthquakes(starttime = "2024-01-01", min_magnitude = 5)


df |>
  select(time, mag, place) |>
  head(10)
#> # A tibble: 10 × 3
#>    time                  mag place                                         
#>    <dttm>              <dbl> <chr>                                         
#>  1 2024-07-01 22:44:53   5.3 Bonin Islands, Japan region                   
#>  2 2024-07-01 10:16:23   5   198 km SE of Kokopo, Papua New Guinea         
#>  3 2024-07-01 05:12:03   5   149 km ESE of Saipan, Northern Mariana Islands
#>  4 2024-07-01 02:38:03   5.1 Balleny Islands region                        
#>  5 2024-06-30 18:23:20   5.2 Maug Islands region, Northern Mariana Islands 
#>  6 2024-06-30 16:06:29   5.2 239 km SSW of Singaparna, Indonesia           
#>  7 2024-06-29 16:38:46   5.6 Bouvet Island region                          
#>  8 2024-06-29 11:10:32   5   62 km W of Atka, Alaska                       
#>  9 2024-06-29 07:22:53   5.3 41 km S of Atiquipa, Peru                     
#> 10 2024-06-29 07:05:33   6.1 42 km SSW of Atiquipa, Peru
```

### Get all earthquakes in 2024 in (approximately) Colorado, specfying location bounds with the *rectangle* parameter.

``` r

df <- get_earthquakes(starttime = "2024-01-01", rectangle = c(37, -110, 41, -101))

head(df)
#> # A tibble: 6 × 22
#>   time                latitude longitude depth   mag magType   nst   gap  dmin
#>   <dttm>                 <dbl>     <dbl> <dbl> <dbl> <chr>   <dbl> <dbl> <dbl>
#> 1 2024-06-11 18:04:11     40.6     -108.  5.52   2.6 ml         26    55 0.481
#> 2 2024-06-04 21:51:19     37.3     -105.  3.21   1.9 ml         13    71 0.193
#> 3 2024-06-03 22:29:25     37.0     -105.  7.07   2   ml         13    85 0.167
#> 4 2024-05-28 15:06:41     37.3     -104.  5      1.2 ml          7   137 0.156
#> 5 2024-05-16 22:19:41     37.2     -105.  5      0.8 ml          7    99 0.099
#> 6 2024-05-16 10:07:20     37.0     -105.  3.01   2.2 ml         13    85 0.163
#> # ℹ 13 more variables: rms <dbl>, net <chr>, id <chr>, updated <dttm>,
#> #   place <chr>, type <chr>, horizontalError <dbl>, depthError <dbl>,
#> #   magError <dbl>, magNst <dbl>, status <chr>, locationSource <chr>,
#> #   magSource <chr>
```
