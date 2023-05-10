library("readxl")
library( "ggplot2")
library("dplyr")
library("tidyverse")

# Reporte hecho con el archivo C8 del INEI.
# https://www.inei.gob.pe/estadisticas/indice-tematico/tecnologias-de-la-informacion-y-telecomunicaciones/

# Creamos vector del header
years <- seq(2011,2021,by=1)
title <- c("Departamento", years)


# Formateamos el excel y convertimos a df
area_dep_df <- read_excel("data/c8.xlsx", range = "A40:L46")
area_dep_df <- data.frame(area_dep_df)

# Ponemos título a nuestro df
colnames(area_dep_df) <-title

# Normalizamos
area_dep_df <- area_dep_df %>%
  pivot_longer(c(`2011`,`2012`,`2013`,
                 `2014`,`2015`,`2016`,
                 `2017`,`2018`,`2019`,
                 `2020`,`2021`,),
               names_to="año",
               values_to="porcentaje")

dep_graph <- ggplot(data=area_dep_df, aes(x=año,y=porcentaje, group=Departamento, label=porcentaje)) +
  geom_line(aes(color=Departamento)) + 
  geom_point(aes(color=Departamento)) +
  #  geom_text(
  #    hjust=0, vjust=0, size=3
  #    ) +
  scale_color_brewer(palette="Spectral") + 
  theme_minimal() + 
  labs(
    title = "Población de 6 y más años de edad que hace uso de Internet",
    subtitle = "Según departamento",
    
    caption = "Fuente: Instituto Nacional de Estadística e Informática"
  ) + 
  xlab("Años (2011 - 2021)") + 
  ylab("Porcentaje")



dep_graph