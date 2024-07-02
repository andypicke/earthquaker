#' Retrieve earthquake data from USGS API
#' @param format Format to return. Default is csv
#' @param starttime Starting date/time in yyyy-mm-dd format (default = 15 days ago)
#' @param endtime Ending date/time in yyyy-mm-dd format (default = today)
#' @param min_magnitude Minimum magnitude (default = 0)
#' @param alert_level (optional) PAGER alert level. c(NA, "green", "yellow", "orange", "red")
#' @param rectangle Bounding box (dec degrees) to limit results to c(minlat, minlon, maxlat, maxlon)
#' @return df Dataframe of earthquakes data with requested parameters.
#' @export
#'
get_earthquakes <- function(format = "csv",
                            starttime = Sys.Date() - 15,
                            endtime = Sys.Date(),
                            min_magnitude = 0,
                            alert_level = c(NA, "green", "yellow", "orange", "red"),
                            rectangle = c(-90, -180, 90, 180)){

  # check if input is valid
  alert_level <- match.arg(alert_level)

  base_url <- "https://earthquake.usgs.gov/fdsnws/event/1/"

  params_str <- paste0("?format=", format,
                       "&starttime=",starttime,
                       "&endtime=", endtime,
                       "&minmagnitude=", min_magnitude,
                       "&minlatitude=", rectangle[1],
                       "&minlongitude=", rectangle[2],
                       "&maxlatitude=", rectangle[3],
                       "&maxlongitude=", rectangle[4])

  if (!is.na(alert_level)) {
    params_str <- paste0(params_str, "&alertlevel=", alert_level)
  }


  # NOTE api has a limit of 20,000 events; will return error code 400 if request exceeds that
  # retrieve count first to check if over limit
  count <- as.numeric(httr::content(httr::GET(paste0(base_url, "count", params_str))))

  if (count > 20000) {
    stop(paste("Requested parameters return too many events: ", count))
  }

  # construct full request url
  req_url <- paste0(base_url, "query", params_str)

  # send the request
  resp <- httr::GET(req_url, httr::user_agent("earthquaker (https://github.com/andypicke/earthquaker)"))

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  # parse the request
  resp_parsed <- httr::content(resp, as = "text")

  # read the returned csv file into a dataframe
  df <- readr::read_csv(
    file = resp_parsed,
    col_names = TRUE,
    show_col_types = FALSE)


}
