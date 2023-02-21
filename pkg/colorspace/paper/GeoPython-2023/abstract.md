# Strategies and Software for Robust Color Palettes in (Geo-)Data Visualizations

* Reto Stauffer (https://orcid.org/0000-0002-3798-5507)
* Achim Zeileis (https://orcid.org/0000-0003-0918-3766)


## Abstract (1-2 Sentences)

Color plays a crucial role in visualizations in the sciences and a
well-designed color map is important for inclusivity, effectiveness, and clear
communication of information. While many software packages nowadays provide adequate
pre-defined color maps and defaults, we will discuss strategies and introduce
software for designing and evaluating customized color maps that are suitable
for a wide range of tasks and applications.


## Description (~1000 chars; 300 words; Markdown possible)

Color is a fundamental aspect of many (geo-)data visualizations including
topographic maps, choropleth maps, heat maps, as well as bar plots, scatter
plots, and time series displays. The careful selection of colors can greatly
enhance the appeal and communication of information in these graphics.
Conversely, poor color choices can impede effective communication and lead to
misunderstandings or confusion.

Recently, many software packages have begun providing a range of pre-defined
color palettes and reasonable defaults for various data types and
visualizations. Nevertheless, the principles for choosing better alternatives
are not always well understood and poor palettes (such as the infamous "rainbow"
or "jet") are still encountered in many situations.

Therefore, we will first discuss a set of strategies for selecting robust and
inclusive color maps for different plot types. Subsequently, we will present a
new Python package `colorspace` that enables the creation of robust custom color
maps using the Hue-Chroma-Luminance (HCL) color model. Additionally, the package
provides graphical tools for evaluating color maps regarding their effectiveness
across a variety of applications and their suitability for viewers with color
vision deficiencies.


## Authors

#### Achim Zeileis

Professor of Statistics at the Faculty of Economics and Statistics at
Universität Innsbruck, Austria. He is co-author and maintainer of various R
software packages, especially for flexible modeling and data visualization. He
is co-editor-in-chief of the open-access Journal of Statistical Software and an
ordinary member of the R Foundation.

#### Reto Stauffer

Associate Professor at the Department of Statistics and the Digital Science
Center (DiSC) at Universität Innsbruck, Austria. His research is on the
intersection of (geo/spatial) data science and atmospheric science, ranging from
probabilistic modeling to data management, visualization, and applications,
especially in weather forecasting. He is technical editor of the open-access
Journal of Statistical Software.
