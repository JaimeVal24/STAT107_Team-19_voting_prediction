scatterplot <- function(var1, var2, var1_Name, var2_Name){
  options(scipen = 5)

plot(var1, var2,
     main = paste(var1_Name, "vs. ", var2_Name),
     xlab = paste(var1_Name),
     ylab = paste(var2_Name))

abline(lm(var2 ~ var1, data = joined_data), col = "red", lwd = 2)
}