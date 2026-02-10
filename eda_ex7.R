# ================================
# OVER-PLOTTING REDUCTION LAB (R)
# Dataset already provided
# ================================

# Load required libraries
library(ggplot2)
library(dplyr)
library(hexbin)
library(viridis)

# -------------------------------
# Step 1: Baseline Over-Plotted Plot
# -------------------------------

ggplot(social_data, aes(x = time_spent, y = likes)) +
  geom_point() +
  labs(
    title = "Baseline Scatter Plot (Over-Plotting Present)",
    x = "Time Spent",
    y = "Likes"
  )

# -------------------------------
# Step 2: Alpha Blending
# -------------------------------

ggplot(social_data, aes(x = time_spent, y = likes)) +
  geom_point(alpha = 0.1, color = "blue") +
  labs(
    title = "Over-Plotting Reduced Using Alpha Blending",
    x = "Time Spent",
    y = "Likes"
  )

# -------------------------------
# Step 3: Jittering
# -------------------------------

ggplot(social_data, aes(x = time_spent, y = likes)) +
  geom_jitter(
    alpha = 0.1,
    width = 0.2,
    height = 0.5,
    color = "darkgreen"
  ) +
  labs(
    title = "Over-Plotting Reduced Using Jittering",
    x = "Time Spent",
    y = "Likes"
  )

# -------------------------------
# Step 4: Aggregation & Binning
# -------------------------------

# Hexagonal binning (best for large datasets)
ggplot(social_data, aes(x = time_spent, y = likes)) +
  geom_hex(bins = 40) +
  scale_fill_viridis() +
  labs(
    title = "Engagement Density Using Hexagonal Binning",
    x = "Time Spent",
    y = "Likes",
    fill = "Count"
  )

# -------------------------------
# Step 5: 2D Density Plot
# -------------------------------

ggplot(social_data, aes(x = time_spent, y = likes)) +
  stat_density_2d(
    aes(fill = ..level..),
    geom = "polygon",
    alpha = 0.8
  ) +
  scale_fill_viridis() +
  labs(
    title = "Engagement Patterns Using Density Estimation",
    x = "Time Spent",
    y = "Likes"
  )

# -------------------------------
# Step 6: Aggregated Summary View
# -------------------------------

aggregated_data <- social_data %>%
  mutate(time_bin = cut(time_spent, breaks = 20)) %>%
  group_by(time_bin) %>%
  summarise(
    avg_likes = mean(likes, na.rm = TRUE),
    count = n()
  )

ggplot(aggregated_data, aes(x = time_bin, y = avg_likes)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = "Aggregated Engagement (Average Likes by Time Spent)",
    x = "Time Spent Bins",
    y = "Average Likes"
  )

# ================================
# END OF SCRIPT
# ================================
