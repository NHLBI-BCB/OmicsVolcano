# ====================================================================
# ====================================================================
# ====================================================================
# Title:      OmicsVolcano 
# Copyright:  (C) 2020
# License:    GNU General Public
# ====================================================================
# ====================================================================
# ====================================================================




# ====================================================================
# ====================================================================
# ====================================================================
# Script Developers 
# ====================================================================
# ====================================================================
# ====================================================================

# Author:    Irina Kuznetsova
# email:     irina.kuznetsova@perkins.org.au

# Co-author: Artur Lugmayr
# email:     lartur@acm.org




# ====================================================================
# ====================================================================
# ====================================================================
# License
# ====================================================================
# ====================================================================
# ====================================================================

# OmicsVolcano is visualization software that enables to explore interactively
# volcano plot for presence of mitochondrial localized genes or proteins.
# 
#     Copyright (C) 2020  Irina Kuznetsova
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.




# ====================================================================
# ====================================================================
# ====================================================================
# INSTALL
# ====================================================================
# ====================================================================
# ====================================================================

# install.packages("dplyr")
# install.packages("tidyverse")
# install.packages('shiny')
# install.packages("plotly")
# install.packages('DT')
# install.packages("shinydashboard")
# install.packages("ggplot2") 
# install.packages("svglite")
# install.packages("stringr")
# install.packages("shinyWidgets")
# install.packages("devtools")




# ====================================================================
# ====================================================================
# ====================================================================
# HELPER FUNCTIONS
# ====================================================================
# ====================================================================
# ====================================================================

modify_stop_propagation <- function(x) {
  x$children[[1]]$attribs$onclick = "event.stopPropagation()"
  x
}




# ====================================================================
# ====================================================================
# ====================================================================
# STATUS BAR IMPLEMENTATION
# ====================================================================
# ====================================================================
# ====================================================================


# --------------------------------------------------------------------
# STATUS AND ERROR BAR
# --------------------------------------------------------------------

ui_info_box <- box(width = 12,
                   fluidRow(
                     width = 12,
                     # A static infoBox
                     infoBoxOutput("UI_INFO_GENERAL"),
                     infoBoxOutput("UI_INFO_PROCESS"),
                     infoBoxOutput("UI_INFO_EXPLORE")
                     )
)




# ====================================================================
# ====================================================================
# ====================================================================
# UI COMPONENTS AND ELEMENTS
# ====================================================================
# ====================================================================
# ====================================================================

# --------------------------------------------------------------------
# GENERAL ELEMENTS
# --------------------------------------------------------------------

ui_menue_body_elements = c("menue_tab_home_body", "menue_tab_file_open_body")

# --------------------------------------------------------------------
# DOWNLOAD DEMO FILE LINK
# --------------------------------------------------------------------

ui_download_demo_file <-
  tags$a(
    href   = CONST_DEMO_FILE,
    target = "_blank",
    icon = icon("fa fa-heart"),
    #style  = "font-size: 12px; font-family: Arial, sans-serif; color:#369C99;",
    icon("disk"),
    "Download demo file to local PC...",
    download = "demofile.txt"
  )

# --------------------------------------------------------------------
# FILE UPLOAD
# --------------------------------------------------------------------
ui_file_input_diag <- box (
  width = 12,
  #  fluidRow (
  checkboxInput(
    inputId = "UI_INPUT_FILE_REMOVE_DUPLICATES",
    label = "Check for Duplicates",
    value = FALSE
  ),
  radioButtons(
    inputId = "UI_INPUT_FILE_SEPARATOR",
    "File Separator",
    choices = c(
      Comma = ",",
      Semicolon = ";",
      Tab = "\t"
    ),
    selected = "\t"
  ),
  
  tags$hr(),
  
  ui_download_demo_file,
  
  tags$hr(),
  
  fileInput(
    inputId  = "UI_INPUT_FILE_NAME",
    label = NULL,
    buttonLabel = "Open...",
    multiple = FALSE,
    accept   = c("text/csv",
                 "text/comma-separated-values,text/plain",
                 ".csv")
  ),
  
  DTOutput(outputId     = "UI_INPUT_FILE_RESULTS")
  
  #    mainPanel(
  #      tableOutput("UI_INPUT_FILE_RESULTS")
  
  #    )
  #  )
)

# # --------------------------------------------------------------------
# # CONFIGURATION BOX
# # --------------------------------------------------------------------
# 
# ui_configuration_box <- boxPlus(
#   title = "Configuration",
#   closable = FALSE,
#   width = 12,
#   status = "warning",
#   enable_label = TRUE,
#   label_text = 1,
#   gradientColor = "maroon",
#   boxToolSize = "xs",
#   icon = "fa fa-heart",
#   solidHeader = TRUE,
#   collapsible = TRUE,
#   enable_dropdown = TRUE,
#   
#   dropdown_icon = "wrench",
#   dropdown_menu = dropdownItemList(
#     dropdownItem(url = "http://www.google.com", name = "Link to google"),
#     dropdownItem(url = "#", name = "item 2"),
#     dropdownDivider(),
#     dropdownItem(url = "#", name = "item 3"),
#     dropdownItem(p("this is to add all the values....."))
#   ),
#   
#   enable_sidebar = TRUE,
#   sidebar_width = 100,
#   sidebar_start_open = FALSE,
#   sidebar_content = tagList(p("value asdf asdf asdf asdf asdf asdf asdf")),
#   footer = "test",
#   
#   ###########################################################################################################
#   # 1.2.2. - TAB3. CONFIGURE
#   ###########################################################################################################
#   sliderInput(
#     inputId = "UI_Signif",
#     label = "Significance",
#     min = 0,
#     max = 0.1,
#     value = c(0.05),
#     step = 0.01,
#     round = -3
#   ),
#   p("\n"),
#   numericInput(
#     "UI_VerticalThreshold",
#     label = "Plot Vertical Threshold",
#     value = 1,
#     min   = 1,
#     max   = 1000,
#     step  = 0.5
#   )
# )
# 
# # --------------------------------------------------------------------
# # STATUSBOX
# # --------------------------------------------------------------------
# 
# ui_status_box <- box(
#   solidHeader = TRUE,
#   title = "Status",
#   background = NULL,
#   width = 12,
#   status = "danger",
#   footer = fluidRow(
#     column(
#       width = 6,
#       descriptionBlock(
#         number = "17%",
#         number_color = "green",
#         number_icon = "fa fa-caret-up",
#         header = "$35,210.43",
#         text = "TOTAL REVENUE - SOME INFO: filename, size, etc.",
#         right_border = TRUE,
#         margin_bottom = FALSE
#       )
#     ),
#     column(
#       width = 6,
#       descriptionBlock(
#         number = "18%",
#         number_color = "red",
#         number_icon = "fa fa-caret-down",
#         header = "1200",
#         text = "GOAL COMPLETION ERROR MESSAGES",
#         right_border = FALSE,
#         margin_bottom = FALSE
#       )
#     )
#   )
# )

# # --------------------------------------------------------------------
# # FILE UPLOAD
# # --------------------------------------------------------------------
#
# ui_menue_file <- fileInput(
#   inputId  = "InputFile",
#   #label   = tags$a(href   ="//uniwa.uwa.edu.au/userhome/staff8/00090658/Desktop/2020/0_Shiny_VolcanoVisual/00_Input/2_INPUT.txt",
#   label    = tags$a(
#     href   = CONST_DEMO_FILE,
#     target = "_blank",
#     style  = "font-size: 12px; font-family: Arial, sans-serif; color:#369C99;",
#     "Download Demo File Locally",
#     download = "demofile.txt"
#   ),
#   multiple = FALSE,
#   accept   = c("text/csv",
#                "text/comma-separated-values,text/plain",
#                ".csv")
# )

# --------------------------------------------------------------------
# THRESHOLD BOX
# --------------------------------------------------------------------

ui_threshold_configuration <- box (
  id = "ui_threshold_configuration",
  color = "orange",
  title = "Threshold",
  solidHeader = TRUE,
  width = 12,
  # Vertical threshold
  numericInput(
    "VerticalThreshold",
    label = "Plot Vertical Threshold",
    value = 1,
    min   = 1,
    max   = 1000,
    step  = 0.5
  ),
  # ARTUR WHAT IS THIS?
  #  verbatimTextOutput("value"),
  # pop-up messages
  # Significanse threshold
  #tags$style(".irs-line {background: red}"),
  
  
  
  tags$style(
    type = "text/css",
    ".irs-grid-text:nth-child(-2n+18) {color: black; }",
    #https://stackoverflow.com/questions/50370958/color-tick-mark-tick-mark-labels-in-sliderinput-shiny
    ".irs-grid-text:nth-child(2n+20) {color: red;   font-size:12}",
    ".irs-grid-pol:nth-of-type(-n+0) {background:black; }",
    ".irs-grid-pol:nth-of-type(n+0) {background:black}"
  ),
  
  
  
  sliderInput(
    inputId   = "Signif",
    label     = "Significance",
    min       = 0,
    max       = 0.1,
    value     = c(0.05),
    step      = 0.01,
    round     = -3
  ),
  # ARTUR DOES NOT WORK  uiOutput("color0")
)

# --------------------------------------------------------------------
# EXPLORE MIROCHONDRIAL PROCESS
# --------------------------------------------------------------------

ui_explore_mitochondrial_process <- box (
  color = "orange",
  title = "Mitochondrial Process",
  solidHeader = TRUE,
  width = 12,
  
  # Organism of interest
  radioButtons(
    inputId  = "OrganismSource",
    label     = "Select Organism",
    choices   = c("Mouse", "Human"),
    inline    = TRUE
  ),
  selectInput(
    inputId   = "MtProcess",
    label     = "Show Mitochondrial Process",
    choices   = c(
      "Show All Mitochondrial Genes",
      "Amino Acid Metabolism",
      "Apoptosis",
      "Bile Acid Synthesis",
      "Calcium Signaling & Transport",
      "Cardiolipin Biosynthesis",
      "Fatty Acid Biosynthesis & Elongation",
      "Fatty Acid Degradation & Beta-oxidation",
      "Fatty Acid Metabolism",
      "Fe-S Cluster Biosynthesis",
      "Folate & Pterin Metabolism",
      "Fructose Metabolism",
      "Glycolysis",
      "Heme Biosynthesis",
      "Import & Sorting",
      "Lipoic Acid Metabolism",
      "Metabolism of Lipids & Lipoproteins",
      "Metabolism of Vitamins & Co-Factors",
      "Mitochondrial Carrier",
      "Mitochondrial Dynamics",
      "Mitochondrial gene expression",
      "Mitochondrial Signaling",
      "Mitophagy",
      "Nitrogen Metabolism",
      "Nucleotide Metabolism",
      "Oxidative Phosphorylation",
      "Oxidative Phosphorylation (mt)",
      "Pentose Phosphate Pathway",
      "Protein Stability & Degradation",
      "Pyruvate Metabolism",
      "Replication & Transcription",
      "ROS Defense",
      "Transcription (nuclear)",
      "Translation",
      "Translation (MT)",
      "Transmembrane Transport",
      "Tricarboxylic Acid Cycle",
      "Ubiquinone Biosynthesis",
      "Unknown MT process",
      "UPRmt"
    )
  )
)

# --------------------------------------------------------------------
# EXPLORE CUSTOM GENE LIST
# --------------------------------------------------------------------

ui_explore_custom_gene_list <- box  (
  color = "orange",
  title = "Custom Gene List",
  solidHeader = TRUE,
  width = 12,
  
  
  radioButtons(
    inputId  = "CustomInputOptions",
    label     = NULL,
    choices   = c("Insert a list of genes", "Upload a gene file"),
    inline    = TRUE
  ),
  # a-Condition to insert own list of genes
  conditionalPanel(
    condition = "input.CustomInputOptions == 'Insert a list of genes'",
    tabPanel(
      title    = "Explore Custom Gene List",
      textInput(
        inputId = "CustomList",
        label   = "Insert a list of genes separated by space",
        value   = "ptcd3 sf1 mrp130"
      )
    )
  ),
  # b-Condition to upload a file with list of genes
  conditionalPanel(
    condition = "input.CustomInputOptions == 'Upload a gene file'",
    fileInput(inputId = "UserGeneNamesFile",
              label   = "Upload a gene file")
  )
  
)


# --------------------------------------------------------------------
# PLOT DOWNLOAD
# --------------------------------------------------------------------

ui_download_plot <- box (
  selectInput(
    inputId  = "PlotDownload",
    label    = "Select Plot",
    choices  = c(
      "Explore Plot Values",
      "Explore Mitochondrial Processes",
      "Explore Custom Gene List"
    ),
    selected = c("Explore Mitochondrial Processes")
  ),
  selectInput(
    inputId  = "Plotfiletype",
    label    = "Plot File Format",
    choices  = c("svg", "pdf", "jpeg", "png", "tiff"),
    selected = "svg"
  ),
  ###actionButton("DownloadPlot", "Download Plot"))), #!!!!!!!!!!!!!!!!!!!!!!!!!
  downloadButton(outputId  = "DownloadPlot",
                 label     = "Download Plot")
)

# --------------------------------------------------------------------
# TABLE DOWNLOAD
# --------------------------------------------------------------------

ui_download_table <- box (
  selectInput(
    inputId  = "TableDownload",
    label    = "Select Table",
    choices  = c("Significant", "Processes"),
    selected = c("Significant")
  ),
  selectInput(
    inputId  = "Tablefiletype",
    label    = "File Format",
    choices  = c("csv", "txt"),
    selected = "csv"
  ),
  downloadButton(outputId     = "DownloadTbl",
                 label        = "Download Table")
)


# ====================================================================
# ====================================================================
# ====================================================================
# RIGHT DASHBOARD SIDEBAR
# ====================================================================
# ====================================================================
# ====================================================================

# list of setting options for the right dasboard menue

function_para_tabs <- tagList (
  tags$style("#params { display:none; }"),
  tabsetPanel (
    id = "params",
    selected = "none",
    tabPanel(
      "menue_tab_exp_plot",
      p("Explore your data for any genes or proteins of interest"),
      ui_threshold_configuration
    ),
    tabPanel(
      "menue_tab_exp_genelist",
      p(
        "Type in a list of gene names of interest in the tab below, separated by spaces. Alternatively, upload an own file with one gene name per row. Genes that are present in your data will be visualized as a Volcano Plot"
      ),
      ui_threshold_configuration,
      ui_explore_custom_gene_list
    ),
    tabPanel(
      "menue_tab_exp_mitproc",
      p("Explore your data for mitochondrial processes"),
      ui_threshold_configuration,
      ui_explore_mitochondrial_process
    ),
    tabPanel("none",
             p("No settings available"))
  )
)

# right dashboard configuration

ui_right_sidebar <- rightSidebar(background = "light",
                                 width = 350,
                                 h1("Settings"),
                                 function_para_tabs)




# ====================================================================
# ====================================================================
# ====================================================================
# LEFT DASHBOARD SIDEBAR
# ====================================================================
# ====================================================================
# ====================================================================

ui_dash_sidebar <- dashboardSidebar(
  collapsed = FALSE,
  disable = FALSE,
  sidebarMenu(
    id = "ui_dashboard_sidebar",
    sartExpanded = TRUE,
    #    modify_stop_propagation(
    menuItem("Home Page",
             tabName = "menue_tab_home",
             icon = icon("home")),
    menuItem(
      "File",
      icon = icon("database"),
      menuSubItem(
        "Open...",
        tabName = "menue_tab_file_open",
        icon = icon("folder-open")
      )
    ),
    menuItem(
      "Explore",
      icon = icon("eye"),
      menuSubItem("Plot",
                  tabName = "menue_tab_exp_plot",
                  icon = icon("image")),
      menuSubItem("Custom Gene List",
                  tabName = "menue_tab_exp_genelist",
                  icon = icon("dna")),
      menuSubItem(
        "Mitochondrial Process",
        tabName = "menue_tab_exp_mitproc",
        icon = icon("project-diagram")
      )
    ),
    menuItem(
      "Export",
      icon = icon("save"),
      menuSubItem("Plot",
                  tabName = "menue_tab_download_plot",
                  icon = icon("file-export")),
      menuSubItem("Table",
                  tabName = "menue_tab_download_table",
                  icon = icon("file-export"))
    ),
#    menuItem("EXIT"), icon = icon ("sign-out-alt"), tabName ="menue_tab_exit",
    menuItem("Help", icon = icon("question"), tabName = "menue_tab_help"),
    menuItem("About", icon = icon("info"), tabName = "menue_tab_about")
    
  )
)

# --------------------------------------------------------------------
# BODY ELEMENTS
# --------------------------------------------------------------------

#
# MENUE ITEMS FOR BODY TAB
#

# HOMEPAGE
menue_tab_home_body <- tabItem(
  "menue_tab_home",
  h1("Home Page"),
  
  # Textual info at HOME page
  mainPanel(
    style = "font-family: 'Arial, sans-serif'; color: black;",
    br(),
    br(),
    h3("OmicsVolcano", align = "left", style = "font-family: 'Arial, sans-serif'; color:#48D1CC;"),
    h4(
      "OmicsVolcano is visualization software that enables to explore interactively volcano plot for presence of mitochondrial localized genes or proteins"
    ),
    
    br(),
    tags$footer("Copyright (C) 2020", style =
                  "position:absolute; bottom:0; left: 10%; padding:5px;")
    
  )
)

#
# EXPLORE PLOT VALUES
#
menue_tab_exp_plot_body <- tabItem(
  "menue_tab_exp_plot",
  h1("Explore Plot Values"),
  
  #  ui_threshold_configuration,
  helpText("Explore your data for any genes/proteins of interest"),
  #  splitLayout(
  #    cellWidths = c("65%", "35%"),
  
#  fluidRow (width = 12,
            
#            box (
#              with = 12,

#fluidRow (
#  width = 10,
  plotlyOutput(outputId = "volcanoPlotNuclear"),
  
#),
   # plotlyOutput(outputId = "volcanoPlotNuclear"),
#            )),
  #  ),

br(),
br(),
# IRNA:
#  box(DTOutput(outputId     = "TableOutExploreNucl")),
  fluidRow (
    width = 12, 
    tabBox(
    width  = 12,
    # Table INPUT, SIGNIF
    tabPanel(title  = "InputData",
             DTOutput(outputId = "InputOriginalData")),
    tabPanel(title  = "Signific",
             DTOutput(outputId = "SignifData"))
  ))
)

# 
#
#

menue_tab_exp_genelist_body <- tabItem(
  "menue_tab_exp_genelist",
  h1("Explore Custom Gene List"),
  
  #  ui_explore_custom_gene_list,
  
  
  # Plot3 and Table
  helpText(
    "Type in a list of gene names of interest in 'Explore Custom Gene List' tab, separated by space or upload own file with one gene per row Genes that are present in your data will be visualized on Volcano Plot"
  ),
  # tags$hr(style="border-color: #48D1CC;"),
  #textInput(inputId     = "CustomList", label ="List of genes, separated by space", value = "ptcd3 sf1 mrpl30"),
  fluidRow(
    width = 10,
    plotlyOutput(outputId = "CustomisedPlot")
  ),

  br(),
  br(),
  fluidRow(
    width = 12,
    tabBox(
      width = 12, 
      tabPanel(
        title = "Data",
        DTOutput(outputId = "CustomisedTable")
      )
      
    )


  )
)

#
#
#

menue_tab_exit_body <- tabItem (
  "menue_tab_exit",
  h1("Exit Application"),
  p("Are you sure you would like to exit the application?"),
  actionButton (
    "ExitApplication",
    "Exit"
  )
)
#
#
#

menue_tab_exp_mitproc_body <- tabItem(
  "menue_tab_exp_mitproc",
  h1("Explore Mitochondrial Process"),
  #  ui_explore_mitochondrial_process,
  
  title = "Explore Mitochondrial Processes",
  #Plot2
  helpText("Explore your data for mitochondrial processes."),
#  splitLayout(
#    cellWidths = c("65%", "35%"),
fluidRow(
  width = 10,

    plotlyOutput(outputId = "VolcanoPlotOutExploreMito")
),
#    DTOutput(outputId     = "TableOutExploreMT")
#  ),


br(),
br(),

  tabBox (
    width  = 12,
    # Table INPUT, SIGNIF, PROCESSES
    tabPanel(title  = "InputData",
             DTOutput(outputId = "InputOriginalData2")),
    tabPanel(title  = "Signific",
             DTOutput(outputId = "SignifData2")),
    tabPanel(title  = "Processes",
             #h2("test this tab"),
             DTOutput(outputId = "ProcessesData"))
    
  )
)

#
#
#


menue_tab_file_open_body <- tabItem("menue_tab_file_open",
                                    h1("Open File"),
                                    ui_file_input_diag)

# fileInput(inputId  = "InputFile",
#           #label   = tags$a(href   ="//uniwa.uwa.edu.au/userhome/staff8/00090658/Desktop/2020/0_Shiny_VolcanoVisual/00_Input/2_INPUT.txt",
#           label    = tags$a(href   = CONST_DEMO_FILE,
#                             #target = "_blank",
#                             style  = "font-size: 12px; font-family: Arial, sans-serif; color:#369C99;",
#                             "Download Demo File Locally",
#                             download ="demofile.txt"),
#           multiple = FALSE,
#           accept   = c("text/csv",
#                        "text/comma-separated-values,text/plain",
#                        ".csv")),)



#
#
#))
menue_tab_download_plot_body <-
  tabItem("menue_tab_download_plot",
          ui_download_plot)

#
#
#

menue_tab_download_table_body <-
  tabItem ("menue_tab_download_table",
           ui_download_table)


menue_tab_help_body <-
  tabItem ("menue_tab_about",
           fluidRow(
             width = 12,
             h1("About"),
             includeHTML("www/AboutPage.html")
           )

           )

menue_tab_about_body <-
  tabItem ("menue_tab_help",
           h1("Help"),
           includeHTML("www/HelpPage.html")
           )
# FILE
# - Open File...
# - Open & Convert File...
# (duplicates removal -> extension, Open File and remove duplicates
#   - Save Demo File...
#   - Close

# tabPanel(
#   fileInput("file1", "Choose CSV File",
#             accept = c(
#               "text/csv",
#               "text/comma-separated-values,text/plain",
#               ".csv")
#   )




# ====================================================================
# ====================================================================
# ====================================================================
# MAIN USER INTERFACE CONTAINER
# ====================================================================
# ====================================================================
# ====================================================================

ui =
  # navbarPage("Application",
  #
  #   navbarMenu("More",
  #              ui_menue_file,
  #
  #
  #              "----",
  #              "Section header",
  #              tabPanel("Table")
  #   ),
  
dashboardPagePlus(

  skin = "yellow",

  dashboardHeaderPlus(
    dropdownMenuOutput("UI_NOTIFICATIONS"),
    enable_rightsidebar = TRUE,
    rightSidebarIcon = "gears",
    title = "OmicsVolcano"
  ),
  ui_dash_sidebar,
  
  
  rightsidebar = ui_right_sidebar,
  
  
  dashboardBody (
    fluidRow(width = 12,
             
             ui_info_box),
    
    #   fluidPage(
    #
    # #  tags$head(
    # #    tags$link(rel = "stylesheet", type = "text/css", href = "style4March.css")
    # #  ),
    #   title = "",
    #   theme = "simplex.min.artur.css",
    #   #theme = shinytheme("paper"),
    #   #theme = "style4March.css",
    #
    #   fluidRow(column(
    #     4,
    #     ui_configuration_box,
    #     ui_status_box,
    #
    #     column(
    #       6,
    #       boxPlus(
    #         title = "Closable Box with dropdown",
    #         closable = TRUE,
    #         width = NULL,
    #         status = "warning",
    #         solidHeader = FALSE,
    #         collapsible = TRUE,
    #         enable_dropdown = TRUE,
    #         dropdown_icon = "wrench",
    #         dropdown_menu = dropdownItemList(
    #           dropdownItem(url = "http://www.google.com", name = "Link to google"),
    #           dropdownItem(url = "#", name = "item 2"),
    #           dropdownDivider(),
    #           dropdownItem(url = "#", name = "item 3")
    #         ),
    #         p("Box Content")
    #       ),
    #
    #     )
    #   )),
    #   ),
    # tabItems(
    #   tabItem(
    #     "subitem1",
    #
    #
    #     fileInput(
    #       inputId  = "InputFile",
    #       label = NULL,
    #       buttonLabel = "Open & Convert...",
    #       multiple = FALSE,
    #       accept   = c("text/csv",
    #                    "text/comma-separated-values,text/plain",
    #                    ".csv")
    #     )
    #   ),
    
    
    # lapply(
    #    ui_menue_body_elements,
    #    FUN = function(x){
    #      eval(parse(x))
    #    }
    # ),
    #eval(parse("menue_tab_file_open_body")),
    fluidRow(
      width = 12,
      tabItems (
        menue_tab_file_open_body,
        menue_tab_home_body,
        
        menue_tab_exp_plot_body,
        menue_tab_exp_genelist_body,
        menue_tab_exp_mitproc_body,
        
        menue_tab_download_plot_body,
        menue_tab_download_table_body,
        
        menue_tab_help_body,
        menue_tab_about_body
#        menue_tab_exit_body
        
      )
    )
  )
)







# ====================================================================
# ====================================================================
# ====================================================================
# V. Versions
# ====================================================================
# ====================================================================
# ====================================================================

# > sessionInfo()
# R version 3.6.1 (2019-07-05)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows >= 8 x64 (build 9200)
# 
# Matrix products: default
# 
# locale:
#   [1] LC_COLLATE=English_Australia.1252  LC_CTYPE=English_Australia.1252    LC_MONETARY=English_Australia.1252
# [4] LC_NUMERIC=C                       LC_TIME=English_Australia.1252    
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] shinyjs_1.1              shinythemes_1.1.2        shinydashboardPlus_0.7.0 config_0.3               crosstalk_1.0.0         
# [6] stringr_1.4.0            svglite_1.2.2            DT_0.11                  plotly_4.9.1             ggplot2_3.2.1           
# [11] shinyWidgets_0.5.1       shinydashboard_0.7.1     dplyr_0.8.3              shiny_1.4.0             
# 
# loaded via a namespace (and not attached):
#   [1] tidyselect_0.2.5  purrr_0.3.3       colorspace_1.4-1  vctrs_0.2.1       htmltools_0.4.0   viridisLite_0.3.0 yaml_2.2.0       
# [8] rlang_0.4.2       later_1.0.0       pillar_1.4.3      glue_1.3.1        withr_2.1.2       gdtools_0.2.1     lifecycle_0.1.0  
# [15] munsell_0.5.0     gtable_0.3.0      htmlwidgets_1.5.1 fastmap_1.0.1     httpuv_1.5.2      Rcpp_1.0.2        xtable_1.8-4     
# [22] promises_1.1.0    scales_1.0.0      backports_1.1.5   jsonlite_1.6      mime_0.7          systemfonts_0.1.1 digest_0.6.21    
# [29] stringi_1.4.3     grid_3.6.1        tools_3.6.1       magrittr_1.5      lazyeval_0.2.2    tibble_2.1.3      crayon_1.3.4     
# [36] tidyr_1.0.0       pkgconfig_2.0.3   zeallot_0.1.0     data.table_1.12.8 assertthat_0.2.1  httr_1.4.1        rstudioapi_0.10  
# [43] R6_2.4.0          compiler_3.6.1   
