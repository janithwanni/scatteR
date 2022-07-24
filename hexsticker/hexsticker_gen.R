library(hexSticker)
library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Poppins", "Poppins",db_cache=FALSE)
## Automatically use showtext to render text for future devices
showtext_auto()

## use the ggplot2 example
# <a href="https://www.flaticon.com/free-icons/powder" title="powder icons">Powder icons created by Freepik - Flaticon</a>
# <a href="https://www.flaticon.com/free-icons/sprinkles" title="sprinkles icons">Sprinkles icons created by Freepik - Flaticon</a>
imgurl <- "hexsticker/sprinkles.png"
sticker(imgurl, package="scatteR", p_size=24, s_x=1.05, s_y=.75, p_y = 1.5,
        s_width=0.5, s_height=0.5,h_fill="#ffffff",p_color = "#FC87B2",
        h_color = "#fc759d",p_fontface = "bold",
        p_family = "Poppins", filename="hexsticker/hexsticker.png")
