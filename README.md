
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scatteR

<!-- badges: start -->
<!-- badges: end -->

scatteR generates scatterplots based on
[scagnostic](https://cran.r-project.org/web/packages/scagnostics/index.html)
measurements. The current implementation uses Simulated Annealing based
on the GenSA package for optimization and rJava is required for the
scagnostics measurement calculation.

## What are these scagnostics?

## Installation

You can install the released version of scatteR from
[Github](https://github.com/janithwanni/scatteR) with:

``` r
install.packages("devtools")
devtools::install_github("janithwanni/scatteR")
```

## Example

### Simple usage

``` r
library(scatteR)
## basic example code
df <- scatteR(measurements = c("Monotonic" = 0.9),n_points = 100)
#> [1] "Epoch 1"
#> It: 1, obj value: 0.06908920274
#> [1] "Epoch 2"
#> It: 1, obj value: 0.02826137844
#> It: 47, obj value: 0.001234673525
#> [1] "Epoch 3"
#> It: 1, obj value: 0.0003086341952
#> [1] "Epoch 4"
#> It: 1, obj value: 0.0001684042791
#> [1] "Epoch 5"
#> [1] "Epoch 6"
#> It: 1, obj value: 4.731619094e-05
#> [1] "Epoch 7"
#> It: 1, obj value: 6.463110673e-05
#> [1] "Epoch 8"
#> It: 1, obj value: 0.0005844103336
#> [1] "Epoch 9"
#> It: 1, obj value: 2.90872382e-05
#> [1] "Epoch 10"
#> It: 1, obj value: 1.092022236e-05
#> [1] "Epoch 11"
#> It: 1, obj value: 4.10444138e-05
#> [1] "Epoch 12"
#> It: 1, obj value: 2.63737808e-06
#> [1] "Epoch 13"
#> It: 1, obj value: 9.462761899e-05
#> [1] "Epoch 14"
#> It: 1, obj value: 6.843463089e-06
#> [1] "Epoch 15"
#> It: 1, obj value: 3.937853737e-06
#> [1] "Epoch 16"
#> It: 1, obj value: 0.005547845654
#> It: 8, obj value: 1.647764738e-06
#> [1] "Epoch 17"
#> It: 1, obj value: 7.81726338e-06
#> [1] "Epoch 18"
#> It: 1, obj value: 2.918974143e-06
#> [1] "Epoch 19"
#> It: 1, obj value: 3.764917101e-05
#> [1] "Epoch 20"
#> It: 1, obj value: 1.067942567e-05
```

``` r
library(scagnostics)
scagnostics(df)
#>  Outlying    Skewed    Clumpy    Sparse  Striated    Convex    Skinny   Stringy 
#> 0.2538847 0.8248022 0.1018009 0.1291258 0.1967213 0.4598955 0.6536334 0.4664043 
#> Monotonic 
#> 0.9000107 
#> attr(,"class")
#> [1] "scagnostics"
```

``` r
plot(df$x,df$y)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### Integration into the tidy workflow

``` r
library(tidyverse)
scatteR(c("Stringy" = 0.9),n_points = 100) %>% # data generation
  mutate(label = ifelse(y > x,"Upper","Lower")) %>% # data preprocessing
  ggplot(aes(x = x,y = y,color=label))+
  geom_point()+
  theme_minimal()+
  theme(legend.position = "bottom")
#> [1] "Epoch 1"
#> [1] "Epoch 2"
#> [1] "Epoch 3"
#> [1] "Epoch 4"
#> [1] "Epoch 5"
#> [1] "Epoch 6"
#> [1] "Epoch 7"
#> [1] "Epoch 8"
#> [1] "Epoch 9"
#> It: 1, obj value: 0.09934402332
#> [1] "Epoch 10"
#> It: 1, obj value: 0.06629350702
#> [1] "Epoch 11"
#> It: 1, obj value: 0.03616240147
#> [1] "Epoch 12"
#> It: 7, obj value: 0.003361880466
#> [1] "Epoch 13"
#> [1] "Epoch 14"
#> It: 1, obj value: 0.09295584075
#> [1] "Epoch 15"
#> [1] "Epoch 16"
#> [1] "Epoch 17"
#> It: 1, obj value: 7.79039731e-05
#> [1] "Epoch 18"
#> It: 1, obj value: 7.79039731e-05
#> [1] "Epoch 19"
#> It: 1, obj value: 7.79039731e-05
#> [1] "Epoch 20"
#> It: 1, obj value: 7.79039731e-05
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
