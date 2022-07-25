#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny, bs4Dash
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    bs4Dash::dashboardPage(
      
      dashboardHeader(title = "Finance Dictionary"),
      
      footer = bs4DashFooter(
        left = dashboardBrand(
          title = NULL,
          href = 'https://finor.tech/',
          image = 'www/finor_arrow.png'
        ),
        right = 'Powered by Finor Apps'),
      
      dashboardSidebar(
        sidebarMenu(
          id = "current_tab",
          flat = FALSE,
          compact = FALSE,
          childIndent = TRUE,
          menuItem(
            "Questionário",
            tabName = "forms",
            icon = icon("sliders-h")
          ) #,
          # menuItem(
          #   "Sobre o Dicionário",
          #   tabName = "dictionary",
          #   icon = icon("id-card")
          # ) ,
          # menuItem(
          #   "Finor",
          #   tabName = "finor",
          #   icon = icon("tint")
          # )
        )
      ),
      
      dashboardBody(tabItems(tab_forms, 
                             tab_fin_dictionary,
                             tab_finor))
      
    )
    # Your application UI logic 
    
    )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny, bs4Dash
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = 'www/favicon.ico',
      app_title = 'findictionary'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

