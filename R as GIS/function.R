# To query HERE API and retrieve isochrones (courtesy of Hannah Recht) ----

tryLocation <- function(location) {
  
  out <- tryCatch({
    temp <- isoline(
      poi = location,
      # range is in seconds - we want 45 minutes, so multiply by 60
      range = 45 * 60,
      range_type = "time",
      transport_mode = "car",
      url_only = F,
      optimize = "quality",
      traffic = F,
      aggregate = F
    )
    
    temp <- temp %>%
      mutate(facility_id = point_id)
    
    return(temp)},
    
    error = function(cond) {
      message(paste("Hospital ID failed: ", point_id))
      message(paste(cond))
      # Choose a return value in case of error
      return("Error")},
    
    warning = function(cond) {
      message(paste("Hospital ID caused a warning:", point_id))
      message(paste(cond))
      # Choose a return value in case of warning
      return("Warning")
    })    
  
  return(out)
}

## See Hannah's drive time analysis: https://www.hrecht.com/r-drive-time-analysis-tutorial/tutorial.html