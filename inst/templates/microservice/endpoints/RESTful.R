################################################################################
## {plumber} endpoint
################################################################################
# Global code; gets executed at plumb() time.
pkgload::load_all()

#* Health check
#* Respond when you ask it if a service is available.
#* @get utility/healthcheck
function(){
    return(NULL)
}

#* Reflect the input class
#* Return the class of the input.
#* @post utility/class
function(req){
    json <- req$postBody
    x <- json %>% jsonlite::fromJSON(flatten = TRUE)
    return(class(x))
}
