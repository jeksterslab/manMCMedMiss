## ---- test-external-manMCMedMiss-fit
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
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
    mplus_complete_coefs <- c(
      0.20517159,
      0.80349916,
      0.88020110,
      0.28806210,
      0.48237333,
      0.98420686,
      -0.10606843,
      -0.00655774,
      0.00792913
    )
    mplus_complete_se <- c(
      0.12290850,
      0.10928647,
      0.09900229,
      0.05761242,
      0.09647466,
      0.19682483,
      0.07590865,
      0.09822465,
      0.14030017
    )
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
    mplus_missing_coefs <- c(
      0.294326360,
      0.745302860,
      0.871876660,
      0.292516800,
      0.517197490,
      0.988752900,
      -0.094182648,
      0.007208682,
      0.011078586
    )
    mplus_missing_se <- c(
      0.13815306,
      0.11954137,
      0.11197224,
      0.06496027,
      0.11557141,
      0.20962431,
      0.08403133,
      0.11306079,
      0.14721230
    )
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
  text = "fit"
)
