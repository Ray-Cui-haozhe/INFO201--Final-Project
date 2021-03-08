qqnormsim <- function(sample, data) {
  y <- eval(substitute(sample), data)
  simnorm <- stats::rnorm(n = length(y) * 8, mean = mean(y),
                          sd = stats::sd(y))
  df <- data.frame(x       = c(y, simnorm),
                   plotnum = rep(c("data", "sim 1", "sim 2",
                                   "sim 3", "sim 4", "sim 5",
                                   "sim 6", "sim 7", "sim 8"),
                                 each = length(y)))
  ggplot2::ggplot(data = df, ggplot2::aes_string(sample = "x")) +
    ggplot2::stat_qq() + ggplot2::stat_qq_line() +
    ggplot2::facet_wrap( ~ plotnum)
}