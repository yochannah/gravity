% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpml.R
\name{gpml}
\alias{gpml}
\title{Gamma Pseudo Maximum Likelihood (GPML)}
\usage{
gpml(dependent_variable, distance, additional_regressors, robust = FALSE,
  data, ...)
}
\arguments{
\item{dependent_variable}{(Type: character) name of the dependent variable. This variable is logged and then used as 
the dependent variable in the estimation.}

\item{distance}{(Type: character) name of the distance variable that should be taken as the key independent variable 
in the estimation. The distance is logged automatically when the function is executed.}

\item{additional_regressors}{(Type: character) names of the additional regressors to include in the model (e.g. a dummy
variable to indicate contiguity). Unilateral metric variables such as GDPs can be added but those variables have to be 
logged first. Interaction terms can be added.

Write this argument as \code{c(contiguity, common currency, ...)}. By default this is set to \code{NULL}.}

\item{robust}{(Type: logical) whether robust fitting should be used. By default this is set to \code{FALSE}.}

\item{data}{(Type: data.frame) the dataset to be used.}

\item{...}{Additional arguments to be passed to the function.}
}
\value{
The function returns the summary of the estimated gravity model similar to a
\code{\link[stats]{glm}}-object.
}
\description{
\code{gpml} estimates gravity models in their
multiplicative form via Gamma Pseudo Maximum Likelihood.
}
\details{
\code{gpml} is an estimation method for gravity models
belonging to generalized linear models. It is described in \insertCite{Santos2006;textual}{gravity} and the model 
is estimated via \code{\link[glm2]{glm2}} using the gamma distribution and a log-link.

For similar functions, utilizing the multiplicative form via the log-link,
but different distributions, see \code{\link[gravity]{ppml}}, \code{\link[gravity]{nls}}, and \code{\link[gravity]{nbpml}}.

\code{gpml} estimation can be used for both, cross-sectional as well as
panel data, but its up to the user to ensure that the functions can be applied
to panel data.

Depending on the panel dataset and the variables -
specifically the type of fixed effects -
included in the model, it may easily occur that the model is not computable.

Also, note that by including bilateral fixed effects such as country-pair
effects, the coefficients of time-invariant observables such as distance
can no longer be estimated.

Depending on the specific model, the code of the
respective function might have to be changed in order to exclude the distance
variable from the estimation.

At the very least, the user should take special
care with respect to the meaning of the estimated coefficients and variances
as well as the decision about which effects to include in the estimation.

When using panel data, the parameter and variance estimation of the models
may have to be changed accordingly.

For a comprehensive overview of gravity models for panel data
see \insertCite{Egger2003;textual}{gravity}, \insertCite{Gomez-Herrera2013;textual}{gravity} and
\insertCite{Head2010;textual}{gravity}.
}
\examples{
# Example for CRAN checks:
# Executable in < 5 sec
library(dplyr)
data("gravity_no_zeros")

# Choose 5 countries for testing
countries_chosen <- c("AUS", "CHN", "GBR", "BRA", "CAN")
grav_small <- filter(gravity_no_zeros, iso_o \%in\% countries_chosen)

grav_small <- grav_small \%>\%
  mutate(
    lgdp_o = log(gdp_o),
    lgdp_d = log(gdp_d)
  )

fit <- gpml(
  dependent_variable = "flow",
  distance = "distw",
  additional_regressors = c("rta", "iso_o", "iso_d"),
  robust = FALSE,
  data = grav_small
)

}
\references{
For more information on gravity models, theoretical foundations and
estimation methods in general see

\insertRef{Anderson1979}{gravity}

\insertRef{Anderson2001}{gravity}

\insertRef{Anderson2010}{gravity}

\insertRef{Baier2009}{gravity}

\insertRef{Baier2010}{gravity}

\insertRef{Feenstra2002}{gravity}

\insertRef{Head2010}{gravity}

\insertRef{Head2014}{gravity}

\insertRef{Santos2006}{gravity}

and the citations therein.

See \href{https://sites.google.com/site/hiegravity/}{Gravity Equations: Workhorse, Toolkit, and Cookbook} for gravity datasets and Stata code for estimating gravity models.

For estimating gravity equations using panel data see

\insertRef{Egger2003}{gravity}

\insertRef{Gomez-Herrera2013}{gravity}

and the references therein.
}
\seealso{
\code{\link[glm2]{glm2}}, \code{\link[lmtest]{coeftest}},
\code{\link[sandwich]{vcovHC}}
}
