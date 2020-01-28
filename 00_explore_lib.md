00\_explore\_lib.R
================
brooke.anderson
2020-01-27

Which libraries does R search for packages?

``` r
# try .libPaths(), .Library
```

Installed packages

``` r
## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

pkgs <- dplyr::glimpse(installed.packages())
```

    ##  chr [1:227, 1:16] "antiword" "askpass" "assertthat" "backports" ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : chr [1:227] "antiword" "askpass" "assertthat" "backports" ...
    ##   ..$ : chr [1:16] "Package" "LibPath" "Version" "Priority" ...

``` r
pkgs <- as.data.frame(pkgs)

## how many packages?
226
```

    ## [1] 226

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
library(magrittr)
library(tidyverse)
```

    ## -- Attaching packages ------------------------------------------------------------------------------ tidyverse 1.2.1 --

    ## v ggplot2 3.2.1     v purrr   0.3.3
    ## v tibble  2.1.3     v dplyr   0.8.3
    ## v tidyr   1.0.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## -- Conflicts --------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x tidyr::extract()   masks magrittr::extract()
    ## x dplyr::filter()    masks stats::filter()
    ## x dplyr::lag()       masks stats::lag()
    ## x purrr::set_names() masks magrittr::set_names()

``` r
pkgs %>% group_by(Priority) %>% summarize(byPriority = n()) %>% ungroup
```

    ## Warning: Factor `Priority` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 2
    ##   Priority    byPriority
    ##   <fct>            <int>
    ## 1 base                14
    ## 2 recommended         15
    ## 3 <NA>               198

``` r
# 1 base                14
# 2 recommended         15
# 3 NA                 197

pkgs %>% group_by(LibPath) %>% summarize(byLibPath = n()) %>% ungroup
```

    ## # A tibble: 2 x 2
    ##   LibPath                                              byLibPath
    ##   <fct>                                                    <int>
    ## 1 C:/Program Files/R/R-3.6.1/library                          30
    ## 2 C:/Users/brooke.anderson/Documents/R/win-library/3.6       197

``` r
# 1 C:/Program Files/R/R-3.6.1/library                          30
# 2 C:/Users/brooke.anderson/Documents/R/win-library/3.6       196

##   * what proportion need compilation?
pkgs %>% group_by(NeedsCompilation) %>% summarize(byNC = n()) %>% ungroup
```

    ## Warning: Factor `NeedsCompilation` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 2
    ##   NeedsCompilation  byNC
    ##   <fct>            <int>
    ## 1 no                 100
    ## 2 yes                122
    ## 3 <NA>                 5

``` r
# 1 no                  99
# 2 yes                122
# 3 NA                   5
pkgs %>% count(NeedsCompilation) %>% mutate(prop = n / sum(n))
```

    ## Warning: Factor `NeedsCompilation` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <fct>            <int>  <dbl>
    ## 1 no                 100 0.441 
    ## 2 yes                122 0.537 
    ## 3 <NA>                 5 0.0220

``` r
##   * how break down re: version of R they were built on
versions <- pkgs %>% group_by(Version) %>% summarize(byVersion = n()) %>% ungroup

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
```

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
.libPaths()
```

    ## [1] "C:/Users/brooke.anderson/Documents/R/win-library/3.6"
    ## [2] "C:/Program Files/R/R-3.6.1/library"

``` r
.Library
```

    ## [1] "C:/PROGRA~1/R/R-36~1.1/library"

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc)
## use `fields` argument to installed.packages() to get more info and use it!
```
