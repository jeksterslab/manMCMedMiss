## ---- test-simTools-sim-seed
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 taskid,
                 repid) {
    message(text)
    seed <- matrix(
      data = NA,
      nrow = repid,
      ncol = taskid
    )
    for (j in seq_len(taskid)) {
      for (i in seq_len(repid)) {
        seed[i, j] <- .SimSeed(
          taskid = j,
          repid = i
        )
      }
    }
    testthat::test_that(
      text,
      {
        testthat::expect_true(
          all(!duplicated(as.vector(seed)))
        )
      }
    )
  },
  text = "test-simTools-sim-seed",
  taskid = 472,
  repid = 5000
)
