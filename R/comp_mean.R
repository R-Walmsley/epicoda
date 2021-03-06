#' Compositional mean
#'
#' Calculates the compositional mean of a dataset.
#'
#' @param data Dataset to calculate compositional mean of.
#' @param comp_labels The labels of the compositional parts.
#' @inheritParams process_zeroes
#' @inheritParams process_units
#' @return Vector which is the compositional mean.
#' @examples
#' comp_mean(data = simdata, # this is the dataset
#' comp_labels = c("vigorous", "moderate", "light", "sedentary", "sleep"), # this is the labels
#' # of the compositional columns, which we specified above
#' rounded_zeroes = TRUE, # this option specifies that we'll treat the zeroes
#' # as rounded zeroes i.e. we'll impute them. As we've not specified det_limit, the function
#' # will calculate it automatically based on the smallest observed value in the data
#' units = "hr/day" # this is the units. There are pre-specified options "hr/day",
#' # "hr/wk", "min/day", "min/wk" and "unitless".
#' # If you set units = "specified", you can also specify your own units using
#' # specified = c("my_units_name", sum of a composition in these units)
#' )
#' @export
comp_mean <-
  function(data,
           comp_labels,
           rounded_zeroes = TRUE,
           det_limit = NULL,
           units = "unitless",
           specified_units = NULL) {
    # Pre-calculation admin
    det_limit <-
      rescale_det_limit(data = data,
                        comp_labels = comp_labels,
                        det_limit = det_limit)
    data <- normalise_comp(data, comp_labels)
    comp_sum <- as.numeric(process_units(units, specified_units)[2])
    units <- process_units(units, specified_units)[1]

    # Separate out composition
    dCompOnly <- data[, comp_labels]

    # Impute zeroes
    dCompOnly <-
      process_zeroes(dCompOnly, comp_labels, rounded_zeroes, det_limit)

    # Calculate compositional mean
    compos_mean <- data.frame(matrix(nrow = 1, ncol = 0))
    for (activity_type in comp_labels) {
      compos_mean[, activity_type] <- gm(dCompOnly[, activity_type])
    }
    tot_time <- apply(compos_mean[1,], 1, sum)
    comp_mean_normalised <- compos_mean / tot_time
    names(comp_mean_normalised) <- comp_labels
    comp_mean_normalised <- as.data.frame(comp_mean_normalised)
    cm <-
      rescale_comp(comp_mean_normalised,
                   comp_labels = comp_labels,
                   comp_sum = comp_sum)

    # Return compositional mean
    return(cm)
  }
