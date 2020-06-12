library(readxl)
library(dplyr)

scores <- read_excel("scores.xlsx")
head(scores)

hs_cts <- (scores %>% group_by(hair_nm, type) %>% tally)[[3]]
hs_means <- aggregate(scores[, c(3, 8)], list(scores$type, scores$hair_nm), mean)
hs_means$count <- hs_cts
head(hs_means)

mu_cts <- (scores %>% group_by(mu_nm, type) %>% tally)[[3]]
mu_means <- aggregate(scores[, c(5, 8)], list(scores$type, scores$mu_nm), mean)
mu_means$count <- mu_cts
head(mu_means)

st_cts <- (scores %>% group_by(ST, type) %>% tally)[[3]]
st_means <- aggregate(scores[8], list(scores$type, scores$ST), mean)
st_means$count <- st_cts
head(st_means)

hs_means$pen_score <- hs_means$score - 1/(hs_means$count)
mu_means$pen_score <- mu_means$score - 1/(mu_means$count)
st_means$pen_score <- st_means$score - 1/(st_means$count)

names(hs_means)[1] <- "chal_type"
names(hs_means)[2] <- "hs_nm"

names(mu_means)[1] <- "chal_type"
names(mu_means)[2] <- "mu_nm"

names(st_means)[1] <- "chal_type"
names(mu_means)[2] <- "st_nm"

get_hair <- function(lvl, chaltype) {
  valid_hs <- subset(hs_means, chal_type == chaltype & hair_lvl <= lvl)
  if (dim(valid_hs)[1] == 0) {
    return("invalid")
  } else {
    sorted_hs <- valid_hs[order(-valid_hs$pen_score),]
    rownames(sorted_hs) <- 1:nrow(sorted_hs)
    best_hs <- sorted_hs[1, 2]
    lvl_hs <- sorted_hs[1, 3]
    avg_hs <- round(sorted_hs[1, 4], 2)
    return(list(best_hs, lvl_hs, avg_hs))
  }
}

get_mu <- function(lvl, chaltype) {
  valid_mu <- subset(mu_means, chal_type == chaltype & mu_lvl <= lvl)
  if (dim(valid_mu)[1] == 0) {
    return("invalid")
  } else {
    sorted_mu <- valid_mu[order(-valid_mu$pen_score),]
    rownames(sorted_mu) <- 1:nrow(sorted_mu)
    best_mu <- sorted_mu[1, 2]
    lvl_mu <- sorted_mu[1, 3]
    avg_mu <- round(sorted_mu[1, 4], 2)
    return(list(best_mu, lvl_mu, avg_mu))
  }
}

get_st <- function(chaltype) {
  valid_st <- subset(st_means, chal_type == chaltype)
  if (dim(valid_st)[1] == 0) {
    return("invalid")
  } else {
    sorted_st <- valid_st[order(-valid_st$pen_score),]
    rownames(sorted_st) <- 1:nrow(sorted_st)
    best_st <- sorted_st[1, 2]
    avg_st <- round(sorted_st[1, 3], 2)
    return(list(best_st, avg_st))
  }
}

categories <- c('casual', 'royal', 'magical', 'sports', 'formal', 'professional', 'African', 'Spanish',
'punk', 'scifi', 'horror', 'bridal', 'retro', 'Asian')
random_cat <- sample(categories, 1)
get_hair(sample(1:85, 1), random_cat)
