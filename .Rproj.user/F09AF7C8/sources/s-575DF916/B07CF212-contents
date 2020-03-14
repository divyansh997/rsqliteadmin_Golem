#' Databases UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_Databases_ui <- function(id){
  ns <- NS(id)
  tabsetPanel(
    tabPanel(title = "Create Database",
             
             textInput(ns("db_name"), "Create a new database",
                       placeholder = "Your Database Name Here"),
             
             actionButton(ns("create_db"), 'Create Database')
    ),
    tabPanel(title = "View Database",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = ns("select_db"),
                             label = "Choose a database",
                             choices = list.files(path = ".", pattern = "db$")),
                 
                 selectInput(inputId = ns("select_table"),
                             label = "Choose a table",
                             choices = NULL
                 )
               ),
               mainPanel(
                 DT::dataTableOutput(ns("display_table"))
               ) 
             )
    )
  )
}

#' Databases Server Function
#'
#' @noRd 
mod_Databases_server <- function(input, output, session){
  ns <- session$ns
  
  db_list<- list.files(path = ".", pattern = "db$")
  
  observeEvent(input$create_db , { 
    create_db(input$db_name)
    showModal(modalDialog(
      title = "Database Created",
      "The database was created successfully!"
    ))
    updateSelectInput(session,
                      inputId =  "select_db",
                      label = "Choose a database",
                      choices = list.files(path = ".", pattern = "db$"))
  })
  
  observeEvent(input$select_db, {
    conn<- RSQLite::dbConnect(RSQLite::SQLite(), input$select_db)
    updateSelectInput(session,
                      inputId =  "select_table",
                      label = "Choose a table",
                      choices = RSQLite::dbListTables(conn)
    )
  })
  
  output$display_table <- DT::renderDataTable(DT::datatable({
    if(input$select_table!=''){
      conn<- RSQLite::dbConnect(RSQLite::SQLite(), input$select_db)
      query<- paste("SELECT * FROM", input$select_table)
      res<- RSQLite::dbGetQuery(conn, query)
      return(res)
    }
  }))
}

## To be copied in the UI
# mod_Databases_ui("Databases_ui_1")

## To be copied in the server
# callModule(mod_Databases_server, "Databases_ui_1")

