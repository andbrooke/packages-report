#' Which libraries does R search for packages?

# try .libPaths(), .Library
.Library

#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

pkgs <- dplyr::glimpse(installed.packages())
pkgs <- as.data.frame(pkgs)

## how many packages?
226

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
library(magrittr)
library(tidyverse)
pkgs %>% group_by(Priority) %>% summarize(byPriority = n()) %>% ungroup
# 1 base                14
# 2 recommended         15
# 3 NA                 197

pkgs %>% group_by(LibPath) %>% summarize(byLibPath = n()) %>% ungroup
# 1 C:/Program Files/R/R-3.6.1/library                          30
# 2 C:/Users/brooke.anderson/Documents/R/win-library/3.6       196

##   * what proportion need compilation?
pkgs %>% group_by(NeedsCompilation) %>% summarize(byNC = n()) %>% ungroup
# 1 no                  99
# 2 yes                122
# 3 NA                   5
pkgs %>% count(NeedsCompilation) %>% mutate(prop = n / sum(n))

##   * how break down re: version of R they were built on
versions <- pkgs %>% group_by(Version) %>% summarize(byVersion = n()) %>% ungroup
update.packages() ## Do this later

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
.libPaths()
.Library

#' Going further


## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc)
## use `fields` argument to installed.packages() to get more info and use it!

install.packages("here")
library(usethis)
use_course("rstats-wtf/wtf-fix-paths")
