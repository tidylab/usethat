################################################################################
## order-one-pizza Workflow
################################################################################
# Steps -------------------------------------------------------------------
issue_new_order <- function(session){
    generate_uid <- uuid::UUIDgenerate
    session$customer_order <- Order$new(uid = generate_uid())
    session$pizza <- Pizza$new(uid = generate_uid())
    session$customer_order$add_pizza(Pizza = session$pizza)
    return(session)
}

order_pizza <- function(session){
    session$pizza$select_size("medium")
    session$pizza$add_topping(name = "olives", side = "both")
    session$pizza$add_topping(name = "anchovy", side = "right")
    session$pizza$remove_topping(name = "olives")
    session$pizza$review()
    return(session)
}

commit_order <- function(session){
    session$customer_order$commit()
    return(session)
}


# Workflow ----------------------------------------------------------------
session <- new.env()

session %>%
    issue_new_order() %>%
    order_pizza() %>%
    commit_order()
