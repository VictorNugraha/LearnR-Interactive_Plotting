shinyServer(function(input, output) {


# menu 1---
## output untuk plot distrbusi harga per category pada bagian menu 1  
output$cat_total_views <- renderPlotly({
    
    df2 <- ikea_clean %>% 
        filter(category %in% input$select_cat) %>% 
        select(category, price_in_rp)
    
    
    plot2<-
        ggplot(data = df2, aes(x = category, y = price_in_rp)) +
        geom_boxplot() +
        scale_y_continuous(labels = dollar_format(prefix = "Rp ")) +
        theme_minimal() +
        scale_fill_brewer(palette = "Set1") +
        labs(title = "Price Distribution",
             x = "Category",
             y = "Price") +
        theme(legend.position = "none")
    
    ggplotly(plot2)
} 
)

output$total_item <- renderValueBox({
    
    total <- df2 %>% 
        filter(category %in% input$select_cat) %>% 
        nrow()
    
    
    valueBox(
        subtitle = "Total Items",
        value = total,
        color = "blue"
    )
    
})

output$mean_price <- renderValueBox({
    
    mean <- df2 %>% 
        filter(category %in% input$select_cat) %>% 
        group_by(category) %>% 
        summarise(mean = mean(price_in_rp))
    
    valueBox(
        subtitle = "Mean Price",
        value = mean,
        icon = icon("book"),
        color = "red"
    )
    
})

output$designer_freq <- renderPlotly({
    
    data_plot3 <- 
        ikea_clean %>% 
        select(designer) %>% 
        separate_rows(designer, sep = "/") %>%
        group_by(designer) %>% 
        summarise(freq = n()) %>% 
        arrange(-freq) %>% 
        head(input$select_total)
    
    # buat plot
    plot_3 <- ggplot(data  = data_plot3, aes(x = freq,
                                             y = reorder(designer, freq), 
                                             text = glue("Total items: {freq}") )) +
        geom_col(fill = "dodgerblue3", ) +
        labs(title = "Top Products by Designer", 
             x = "Frequency", 
             y = "Designer") +
        scale_y_discrete(labels = function(x)str_wrap(x, width = 10)) +
        theme_minimal() 
    
    # ggplotly
    ggplotly(plot_3, tooltip = "text")
    
} 
)

})