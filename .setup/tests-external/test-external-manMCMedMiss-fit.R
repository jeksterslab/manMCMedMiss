## ---- test-external-manMCMedMiss-fit
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
    message(text)
    if (!exists("params")) {
      try(
        data(
          "params",
          package = "manMCMedMiss"
        ),
        silent = TRUE
      )
    }
    root <- rprojroot::is_rstudio_project
    mplus_bin <- root$find_file(
      ".setup",
      "bin",
      "mpdemo"
    )
    params <- params[which(params$taskid == 59), ]
    n <- params$n
    tauprime <- params$tauprime
    alpha <- params$alpha
    beta <- params$beta
    set.seed(42)
    data_complete <- GenData(
      n = n,
      tauprime = tauprime,
      beta = beta,
      alpha = alpha
    )
    data_missing <- AmputeData(
      data_complete,
      mech = "MAR",
      prop = 0.30
    )
    lav_complete <- lavaan::sem(
      model = "y ~ x + m; m ~ x",
      data = data_complete,
      fixed.x = FALSE,
      meanstructure = TRUE,
      mimic = "Mplus"
    )
    lav_complete_coefs <- lavaan::coef(lav_complete)
    lav_complete_se <- sqrt(diag(lavaan::vcov(lav_complete)))
    fit_complete_ml <- FitModelML(
      data_complete,
      mplus_bin = mplus_bin
    )
    mplus_complete_coefs <- fit_complete_ml$coef
    mplus_complete_se <- sqrt(diag(fit_complete_ml$vcov))
    varnames <- c(
      "y~x",
      "y~m",
      "m~x",
      "y~~y",
      "m~~m",
      "x~~x",
      "y~1",
      "m~1",
      "x~1"
    )
    mplus_complete_coefs <- mplus_complete_coefs[varnames]
    mplus_complete_se <- mplus_complete_se[varnames]
    indirect <- FitModelIndirect(data_complete)
    lav_missing <- lavaan::sem(
      model = "y ~ x + m; m ~ x",
      data = data_missing,
      fixed.x = FALSE,
      meanstructure = TRUE,
      mimic = "Mplus"
    )
    lav_missing_coefs <- lavaan::coef(lav_missing)
    lav_missing_se <- sqrt(diag(lavaan::vcov(lav_missing)))
    fit_missing_ml <- FitModelML(
      data_missing,
      mplus_bin = mplus_bin
    )
    mplus_missing_coefs <- fit_missing_ml$coef
    mplus_missing_se <- sqrt(diag(fit_missing_ml$vcov))
    mplus_missing_coefs <- mplus_missing_coefs[varnames]
    mplus_missing_se <- mplus_missing_se[varnames]
    testthat::test_that(
      paste(text, "complete est"),
      {
        testthat::expect_true(
          all(
            abs(
              lav_complete_coefs - mplus_complete_coefs
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "complete est"),
      {
        testthat::expect_true(
          all(
            abs(
              lav_complete_se - mplus_complete_se
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "complete indirect"),
      {
        testthat::expect_true(
          all(
            abs(
              indirect - lav_complete_coefs[2] * lav_complete_coefs[3]
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "missing est"),
      {
        testthat::expect_true(
          all(
            abs(
              lav_missing_coefs - mplus_missing_coefs
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "missing est"),
      {
        testthat::expect_true(
          all(
            abs(
              lav_missing_se - mplus_missing_se
            ) <= tol
          )
        )
      }
    )
  },
  tol = 0.0001,
  text = "test-external-manMCMedMiss-fit"
)
