## ---- test-manMCMedMiss-gen-data
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    tauprime <- 0
    beta <- 0.5
    alpha <- 0.5
    data <- as.data.frame(
      GenData(
        n = n,
        tauprime = tauprime,
        beta = beta,
        alpha = alpha,
        mu = 0,
        sigmasq = 1
      )
    )
    lm_obj_m <- stats::lm(
      formula = m ~ x,
      data = data
    )
    coefs_m <- stats::coef(lm_obj_m)[-1]
    lm_obj_y <- stats::lm(
      formula = y ~ x + m,
      data = data
    )
    coefs_y <- stats::coef(lm_obj_y)[-1]
    testthat::test_that(
      paste(text, "mu"),
      {
        testthat::expect_true(
          all(
            abs(
              colMeans(data)
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "sigmasq"),
      {
        testthat::expect_true(
          all(
            abs(
              sqrt(diag(stats::cov(data))) - 1
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "m"),
      {
        testthat::expect_true(
          all(
            abs(
              coefs_m - alpha
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "y"),
      {
        testthat::expect_true(
          all(
            abs(
              coefs_y - c(tauprime, beta)
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manMCMedMiss-gen-data",
  n = 10^6,
  tol = 0.01
)
