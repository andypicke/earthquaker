#' Retrieve earthquake data from USGS API
#' @param format Format to return. Default is csv
#' @param starttime Starting date/time (yyyy-mm-dd)
#' @param endtime Ending date/time (yyyy-mm-dd)
#' @return df Dataframe of requested earthquakes data
#' @export
#'
get_earthquakes <- function(format = "csv", starttime = "2024-05-01", endtime = "2024-05-02"){

  # https://earthquake.usgs.gov/fdsnws/event/1/
  base_url <- "https://earthquake.usgs.gov/fdsnws/event/1/"

  params_str <- paste0("?format=", format,
                       "&starttime=",starttime,
                       "&endtime=", endtime)


  # NOTE api has a limit of 20,000 events; will return error code 400 if request exceeds that

  count <- as.numeric(httr::content(httr::GET(paste0(base_url, "count", params_str))))

  if (count > 20000) {
    stop(paste("Requested parameters return too many events: ", count))
  }


  req_url <- paste0(base_url, "query", params_str)
  resp <- httr::GET(req_url)

  resp_parsed <- httr::content(resp, as = "text")

  df <- readr::read_csv(
    file = resp_parsed,
    col_names = TRUE,
    show_col_types = FALSE)


}
