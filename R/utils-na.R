# Timedate ----------------------------------------------------------------
NA_Date_ <- structure(NA_real_, class = "Date")
NA_POSIXct_ <- structure(.POSIXct(NA_real_, tz = "UTC"), class = c("POSIXct", "POSIXt"))


# Arrays ------------------------------------------------------------------
NA_list_ <- structure(list(), class = "list")
NA_data.frame <- structure(data.frame(), class = "data.frame")
