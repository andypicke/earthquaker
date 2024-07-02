
<!-- README.md is generated from README.Rmd. Please edit that file -->

# earthquaker

<!-- badges: start -->

[![R-CMD-check](https://github.com/andypicke/earthquaker/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/earthquaker/actions/workflows/R-CMD-check.yaml)
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

## Example

Get dataframe of earthquakes for a 2 day period:

``` r
library(earthquaker)

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
