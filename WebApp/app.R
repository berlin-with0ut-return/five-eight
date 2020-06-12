library(shiny)
library(readxl)
library(shinyWidgets)

source("helpers.R")


# Define UI for application
ui <- fluidPage(
    
    tags$head(
        tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@900&family=Roboto:wght@300&family=Raleway:wght@300&');
        #sidebar {
            background-color: #ebbdff;
            border-color: white;
            font-family: 'Roboto', sans-serif;
        }
        #hs_nm {
            font-family: 'Roboto', sans-serif;
        }
        #hs_avg {
            font-family: 'Roboto', sans-serif;
        }
        #mu_nm {
            font-family: 'Roboto', sans-serif;
        }
        #mu_avg {
            font-family: 'Roboto', sans-serif;
        }
        #st_nm {
            font-family: 'Roboto', sans-serif;
        }
        #st_avg {
            font-family: 'Roboto', sans-serif;
        }
        #hs_img {
          position:absolute; 
          left: 190px;
        }
        #mu_img {
          position: absolute;
          left: 20px;
        }
        body {
            -moz-transform: scale(1.2, 1.2);
            zoom: 1.2; /* Other non-webkit browsers */
            zoom: 120%; /* Webkit browsers */
        }
    "))
    ),
    
    setBackgroundImage(src = 'Background.png'
    ),

    # Application title
    titlePanel(h1("five-eight", 
                            style = "font-family: 'Montserrat', sans-serif; font-weight: bold; color: #75244e;")),

    sidebarLayout(
        sidebarPanel(id = "sidebar",
            selectInput("chalType", label = h5("Choose your challenge type",
                                               style = "font-family: 'Raleway', sans-serif; font-weight: bold;"), 
                        choices = list("African", "Asian", "bridal",
                                       "casual", "formal", "horror",
                                       "magical", "professional", "punk",
                                       "retro", "royal", "scifi", 
                                       "Spanish", "sports")
                        ),
            numericInput("lvl", label = h5("Choose a level (1 - 85)",
                                           style = "font-family: 'Raleway', sans-serif; font-weight: bold;"), 
                         value = NA, min = 1, max = 85)
        ),
        mainPanel(
          conditionalPanel(
            condition = "input.lvl > 0",
            textOutput("hs_nm"),
            textOutput("hs_avg"),
            br(),
            textOutput("mu_nm"),
            textOutput("mu_avg"),
            br(),
            textOutput("st_nm"),
            textOutput("st_avg"),
            br(),
            div(imageOutput("hs_img")),
            imageOutput("mu_img")
          ),
        )
    )
)

# Define server logic 
server <- function(input, output) {
    
    hs_recs <- reactive({
        get_hair(input$lvl, input$chalType)
    })
    output$hs_nm <- renderText({
        paste("Hairstyle: ", hs_recs()[1], "( Level ", hs_recs()[2], ")")
    })
    output$hs_avg <- renderText({ 
        paste("This hairstyle scores", hs_recs()[3], "on average in", input$chalType, "themed challenges")
    })
    output$hs_img <- renderImage({
      filename <- normalizePath(file.path('./www',
                                          paste(hs_recs()[1], '.gif', sep='')))
      
      # Return a list containing the filename and alt text
      list(src = filename,
           width = "150px",
           height = "auto")
      
    }, deleteFile = FALSE)
    
    mu_recs <- reactive({
        get_mu(input$lvl, input$chalType)
    })
    output$mu_nm <- renderText({ 
        paste("Makeup: ", mu_recs()[1], "( Level ", mu_recs()[2], ')')
    })
    output$mu_avg <- renderText({ 
        paste("This makeup scores", mu_recs()[3], "on average in", input$chalType, "themed challenges")
    })
    output$mu_img <- renderImage({
      filename <- normalizePath(file.path('./www',
                                          paste(mu_recs()[1], '.gif', sep='')))
      
      # Return a list containing the filename and alt text
      list(src = filename,
           width = "150px",
           height = "auto")
      
    }, deleteFile = FALSE)
    
    st_rects <- reactive({
        get_st(input$chalType)
    })
    output$st_nm <- renderText({ 
        paste("Skin tone: ", st_rects()[1])
    })
    output$st_avg <- renderText({ 
        paste("This skin tone scores", st_rects()[2], "on average in", input$chalType, "themed challenges")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)