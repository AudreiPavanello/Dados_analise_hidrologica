library(keras)
library(caret)

# Define the model architecture
model <- keras_model_sequential() %>%
  layer_dense(units = 10, activation = "relu", input_shape = ncol(x_train)) %>%  # Input layer
  layer_dense(units = 1, activation = "linear")  # Output layer with linear activation

# Compile the model
model %>% compile(
  loss = "mean_squared_error",  # Use mean squared error for regression
  optimizer = optimizer_adam()  # Use Adam optimizer
)

# Normalize input features 
x_train <- Train[, c("precip", "eto")]
x_train <- scale(x_train)

# Extract target variable
y_train <- Train$discharge

# Train the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 100,  # Number of training epochs
  batch_size = 32,  # Batch size
  validation_split = 0.2,  # Validation split
  verbose = 2  # Show training progress
)

# Extract input features for validation
x_valid <- normalized_Valid[, c("precip", "eto")]

# Normalize input features for validation
x_valid <- scale(x_valid)

# Predict using the trained model
predictions <- model %>% predict(x_valid)

# Extract true target values for validation
y_valid <- normalized_train[, "discharge"]

# Calculate Mean Squared Error (MSE)
mse <- mean((predictions - Valid$discharge)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Display results
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")








