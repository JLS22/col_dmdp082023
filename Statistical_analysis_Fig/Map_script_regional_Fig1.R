## Geographic distribution of samples used in this study - Fig.1 

## Joana L. Santos 

## Load libraries
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(cowplot)
library(dplyr)
library(readr)

### 1. Dataset

# Read CSV file 
df <- read_csv("dmdp082023_gps_map_215.04042025.csv")

# lineage order 
df$lineage <- factor(df$lineage,
                     levels = c("NorthAmerica", "WesternEurasia", "EastAsia"))

#convert data
df_sf <- st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)



## 2. Load world map
world <- ne_countries(scale = "medium", returnclass = "sf")


## 3. Plot - Figure 1

# Define colors and shapes
lineage_colors <- c("NorthAmerica" = "#fe8088",
                    "WesternEurasia" = "#0097a4",
                    "EastAsia" = "#ab6e77")
lineage_shapes <- c("NorthAmerica" = 15,
                    "WesternEurasia" = 16,
                    "EastAsia" = 17)

# Common y-axis
y_common <- c(15, 75)

# Plot: North America
p_na <- ggplot(world) +
  geom_sf(fill = "lightgrey", color = "black") +
  geom_sf(data = df_sf, aes(color = lineage, shape = lineage), size = 3, show.legend = FALSE) +
  coord_sf(xlim = c(-170, -50), ylim = y_common, expand = FALSE) +
  scale_shape_manual(values = lineage_shapes) +
  scale_colour_manual(values = lineage_colors) +
  theme_minimal() +
  theme(panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_text(size=10))

# Plot: Eurasia 
p_eurasia <- ggplot(world) +
  geom_sf(fill = "lightgrey", color = "black") +
  geom_sf(data = df_sf, aes(color = lineage, shape = lineage), size = 3, show.legend = FALSE) +
  coord_sf(xlim = c(-25, 150), ylim = y_common, expand = FALSE) +
  scale_shape_manual(values = lineage_shapes) +
  scale_colour_manual(values = lineage_colors) +
  theme_minimal() +
  theme(panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_text(size=10))

# Combine the two plots
regional_combined <- plot_grid(p_eurasia, p_na, 
                               ncol = 1, rel_heights = c(1, 1),
                               rel_widths = c(1,1),
                               align = "v", labels = c("A", "B"))

# Save plot
ggsave("figure1_regional_maps.tiff",
       plot = regional_combined,
       width = 18, height = 22, units = "cm", dpi = 300, device = "tiff")

