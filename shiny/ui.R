#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# Bagian untuk membuat head
header <- dashboardHeader(title = "IKEA Dashboard")

# Bagian untuk membuat sidebar
sidebar <- dashboardSidebar(
    #sidebarMenu adalah fungsi untuk membuat bagian menu disamping
    sidebarMenu(
        #menutItem adalah fungsi untuk membuat kolom tab menu dibagian menu samping
        menuItem(
            # text adalah parameter untuk memberikan Nama menu
            text = "Menu 1", 
            # tabName adalah parameter memberikan nama yang mewakliki bagian menu tersebut
            tabName = "menu_1",
            icon = icon("bar-chart-o")),
        
        menuItem(text = "Menu 2",
                 tabName = "menu_2",
                 icon = icon("book"))
    )
)

# Bagian untuk membuat body
body <- dashboardBody(
    tabItems(
        
        tabItem(
            # Pada bagian Menu 1 kita ingin menampilkan 3 plot yang sudah berhasil kita buat
            tabName = "menu_1",
            
            # fluiRow adalah sebuah fungsi untuk membuat layout dengan orientasi baris
            fluidRow(
                
                # box adalah fungsi untuk membuat sebuah box yang dapat diisi dengan berbagai macam output
                box(# title adalah parameter dari box untuk memberikan judul pada box
                    title = "Price Distribution",
                    # width adalah parameter untuk mengatur lebar dari box, maximum width adalah 12
                    width = 12,
                    
                    # selecInput adalah fungsi untuk memilih salah satu category 
                    selectInput(# input Id adalah Id atau dari fungsi selectInput
                        inputId = "select_cat", 
                        # label adalah parameter untuk memberikan nama dari selectInput
                        label = "Select Category:", 
                        # choices adalah parameter untuk memberikan pilihan category apa saja yang bisa dipilih
                        choices = unique(df2$category)
                    ), 
                    
                    # plotlyOutput adalah fungsi untuk menampilkan plot yang sudah dibuat dibagian server
                    plotlyOutput(outputId = "cat_total_views"),
                    
                    br(),
                    
                    valueBoxOutput(outputId = "total_item",
                                   width = 12)
                )
            )
        ),
        
        tabItem(
            # Pada bagian Menu 2 kita ingin menampilkan seluruh data
            tabName = "menu_2",
            
            fluidRow(
                
                box(
                    title = "Designer Total Product",
                    width = 12,
                    height = "600px",
                    
                    sliderInput(
                        inputId = "select_total",
                        label = "Select How Many Designer: ",
                        min = 3,
                        max = 10,
                        value = 5,
                        ticks = FALSE
                    ),
                    
                    plotlyOutput(outputId = "designer_freq")
                )
            )
        )
    )
)

# dashboardPage adalah fungsi untuk memanggil semua bagian yang sudah dibuat
dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar
)