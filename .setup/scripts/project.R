#' Define project related objects here.
#'
#' | Object Name      | Description                                         |
#' |:-----------------|:----------------------------------------------------|
#' | `project`        | Project name.                                       |
#' | `pkg_cran`       | CRAN packages to install on top of                  |
#' |                  | package dependencies in `DESCRIPTION`.              |
#' | `pkg_github`     | GitHub packages to install.                         |
#' | `pkg_github_ref` | GitHub branch corresponding to packages             |
#' |                  | in `pkg_github`. `if (length(pkg_github_ref) == 0)` |
#' |                  | use the `HEAD` branch.                              |
#' | `pkg_ver`        | Packages with specific version.                     |
#' | `ver`            | Version corresponding to packages in `pkg_ver`.     |
#' | `ignore`         | Items to add to `.Rbuildignore`.                    |
#' | `license`        | Options are `"mit"`, `"gpl3"`, or `NULL`            |
#'

project <- "manMCMedMiss"

pkg_cran <- c(
  "semmcci",
  "MASS",
  "mice",
  "party"
)

pkg_github <- c()

pkg_github_ref <- c()

pkg_ver <- c(
  "semmcci",
  "MASS",
  "mice",
  "party"
)

ver <- c(
  "1.1.2",
  "7.3-58.1",
  "3.14.0",
  "1.3-10"
)

ignore <- "^vignettes$"

license <- "mit"

git_user <- "jeksterslab"
git_email <- "learn.jeksterslab@gmail.com"
r_email <- "r.jeksterslab@gmail.com"
