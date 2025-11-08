# This function takes in a dataframe and a vector of columns from the data set. The function deletes all columns from the data set.
remove_cols <- function(data, cols_to_remove) {
  return(data[, !names(data) %in% cols_to_remove])
}

# This functions takes in data and a column. Then it replaces all NA values in the given column with 0.
na_to_zero <- function(data, col_name) {
  # Check if the column exists
  if (!col_name %in% names(data)) {
    return(data)
  }
  
  data[[col_name]][is.na(data[[col_name]])] <- 0
  
  return(data)
}

# This function turns a given dataframes' column into factor type
to_factor <- function(data, col_name) {
  # Check if the column exists
  if (!col_name %in% names(data)) {
    return(data)
  }
  
  data[[col_name]] <- as.factor(data[[col_name]])
  return(data)
}
