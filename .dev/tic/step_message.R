Message <- R6::R6Class(
    "Message",
    inherit = TicStep,
    public = list(
        initialize = function(msg = NULL) self$msg <- msg,
        run = function() message(self$msg),
        msg = character()
    )
)

step_message <- function(msg) {
    Message$new(msg)
}
