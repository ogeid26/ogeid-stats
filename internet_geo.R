library("readxl")
library( "ggplot2")
library("dplyr")
library("tidyverse")

# Reporte hecho con el archivo C8 del INEI.
# https://www.inei.gob.pe/estadisticas/indice-tematico/tecnologias-de-la-informacion-y-telecomunicaciones/

# Creamos vector del header
years <- seq(2011,2021,by=1)
title <- c("Zona", years)


# Formateamos el excel y convertimos a df
area_res <- read_excel("data/c8.xlsx", range = "A11:L13")
area_res_df <- data.frame(area_res)

# Ponemos título a nuestro df
colnames(area_res_df) <-title

# Normalizamos
df <- area_res_df %>%
  pivot_longer(c(`2011`,`2012`,`2013`,
                 `2014`,`2015`,`2016`,
                 `2017`,`2018`,`2019`,
                 `2020`,`2021`,),
               names_to="año",
               values_to="porcentaje")

graph <- ggplot(data=df, aes(x=año,y=porcentaje, group=Zona, label=porcentaje)) +
  geom_line(aes(color=Zona)) + 
  geom_point(aes(color=Zona)) +
  #  geom_text(
  #    hjust=0, vjust=0, size=3
  #    ) +
  scale_color_brewer(palette="Paired") + 
  theme_minimal() + 
  labs(
    title = "Población de 6 y más años de edad que hace uso de Internet",
    subtitle = "Según zona de residencia",
    
    caption = "Fuente: Instituto Nacional de Estadística e Informática"
  ) + 
  xlab("Años (2011 - 2021)") + 
  ylab("Porcentaje")



graph


