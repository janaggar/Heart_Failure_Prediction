View(heart)
alldata<-data.frame(heart)
install.packages("ggplot2")
install.packages("ggplotgui")
install.packages("shiny")
install.packages("zoom")
install.packages("gridExtra")
library("gridExtra")
library("zoom")
library("ggplot2")
library("shiny")
library("dplyr")

# Assuming you have loaded your data into 'alldata' and 'heart' data frames
heart_disease <- as.logical(alldata$HeartDisease)
cholesterol <- as.integer(alldata$Cholesterol)
max_heart_rate <- as.integer(alldata$MaxHR)
chest_pain_type <- as.character(alldata$ChestPainType)

ui <- fluidPage(
  titlePanel("Heart Disease Relationship Analysis"),
  # Tabset with five tabs
  tabsetPanel(
    
    tabPanel("Heart Disease",
             # Nested tabset with 10 tabs
             tabsetPanel(
               tabPanel("Age", plotOutput("agePlot")),
               tabPanel("Gender", plotOutput("genderPlot")),
               tabPanel("Chest Pain", plotOutput("chestPainPlot")),
               tabPanel("Resting Blood Pressure", plotOutput("restingBPPlot")),
               tabPanel("Cholesterol", plotOutput("cholesterolPlot")),
               tabPanel("Fasting Blood Sugar", plotOutput("fastingBSPlot")),
               tabPanel("Resting ECG", plotOutput("ecgPlot")),
               tabPanel("Max Heart Rate", plotOutput("maxHeartRatePlot")),
               tabPanel("Exercise Angina", plotOutput("excersisePlot")),
               tabPanel("ST Slope", plotOutput("STslopePlot"))
             )
    )
    ,tabPanel("Age",
              # Nested tabset with 3 tabs
              tabsetPanel(
                tabPanel("vs Max HR", plotOutput("vsmaxhrPlot")),
                tabPanel("vs Resting BP", plotOutput("vsrestingbpPlot")),
                tabPanel("vs Cholesterol", plotOutput("vscholesterolPlot"))
              )
    )
    ,tabPanel("Cholesterol",
              # Nested tabset with 3 tabs
              tabsetPanel(
                tabPanel("vs Max HR", plotOutput("vsmaxhrPlot2")),
                tabPanel("vs Resting BP", plotOutput("vsrestingbpPlot2")),
                tabPanel("vs Fasting BS", plotOutput("vsfastingbsPlot"))
              )
    )
  )
)

server <- function(input, output) {
  # Chest Pain Plot
  output$chestPainPlot <- renderPlot({
    chestPainPlot.plot <- ggplot(heart, aes(x = heart_disease, fill = chest_pain_type)) +
      geom_bar(position = "dodge") +
      labs(title = "Prevalence of Heart Disease for Different Chest Pain Types",
           x = "Heart Disease", y = "Number of patients",
           fill = "Chest Pain Type")
    print(chestPainPlot.plot)
  })
  # Cholesterol Plot
  output$cholesterolPlot <- renderPlot({
    cholesterolPlot.plot <- ggplot(heart, aes(x = cholesterol, y = heart_disease)) +
      geom_boxplot() +
      labs(x = "Cholesterol", y = "Heart Disease")
    print(cholesterolPlot.plot)
  })
  # Max Heart Rate Plot
  output$maxHeartRatePlot <- renderPlot({
    maxHeartRatePlot.plot <- ggplot(heart, aes(x = max_heart_rate, y = heart_disease)) +
      geom_boxplot() +
      labs(x = "Maximum Heart Rate (bpm)", y = "Heart Disease")
    print(maxHeartRatePlot.plot)
  })
  # Resting Blood Pressure Plot
  output$restingBPPlot <- renderPlot({
    restingBPPlot.plot <- ggplot(heart, aes(x = alldata$RestingBP, y = heart_disease)) +
      geom_boxplot() +
      labs(x = "Resting BP", y = "Heart Disease")
    print(restingBPPlot.plot)
  })
  # Age Plot
  output$agePlot <- renderPlot({
    agePlot.plot <- ggplot(alldata, mapping = aes(x = alldata$Age, fill =as.logical(alldata$HeartDisease))) +
      geom_histogram(position = "dodge") +
      labs(title = "Prevelance of Heart Disease Across Age", x = "Age",
           y = "Number of patients", fill = "Heart Disease")
    print(agePlot.plot)
  })
  # Gender Plot
  output$genderPlot <- renderPlot({
    genderPlot.plot <- Gender<-ggplot(alldata, mapping = aes(x = alldata$Sex, fill = heart_disease)) +
      geom_bar(position = "fill") +
      labs(x = "Sex", y = "Precentage of patients", fill = "Heart Disease",title = "Precentage of Heart Disease by Gender")
    print(genderPlot.plot)
  })
  # Excersise Plot
  output$excersisePlot <- renderPlot({
    excersisePlot.plot <- ggplot(alldata, mapping = aes(x = alldata$ExerciseAngina, fill = heart_disease)) +
      geom_bar(position = "fill") +
      labs(x = "Exercise angina", y = "Number of patients", fill = "Heart Disease",
           title = "Precentage of Heart Disease by Exersise angina")
    print(excersisePlot.plot)
  })
  # Fasting Blood Sugar Plot
  output$fastingBSPlot <- renderPlot({
    fastingBSPlot.plot <- ggplot(alldata, mapping = aes(x = alldata$FastingBS, fill = heart_disease)) +
      geom_bar(position = "fill") +
      labs(x = "High Fasting blood sugar?", y = "Number of patients", fill = "Heart Disease",
           title = "Precentage of Heart Disease by Fasting Blood sugar")
    print(fastingBSPlot.plot)
  })
  # ST Slope Plot
  output$STslopePlot <- renderPlot({
    STslopePlot.plot <- ggplot(alldata,mapping = aes(x=heart_disease, fill=alldata$ST_Slope))+
      geom_bar(position = "dodge")+
      labs(title = "Prevalance of Heart Disease for diffrent ST Slopes", x="Heart Disease", y="Number of Patients", fill="ST Slope Type")
    print(STslopePlot.plot)
  })
  # ECG
  output$ecgPlot <- renderPlot({
    ecgPlot.plot <- ggplot(alldata,mapping = aes(x=heart_disease, fill=alldata$RestingECG))+
      geom_bar(position = "dodge")+
      labs(title = "Prevalance of Heart Disease for Resting ECG", x="Heart Disease", y="Number of Patients", fill="Resting ECG Type")
    print(ecgPlot.plot)
  })
  #Age vs MHR VS SEX   #negative
  output$vsmaxhrPlot <- renderPlot({
    vsmaxhrPlot.plot <- ggplot(heart, mapping = aes(x=alldata$Age, y=alldata$MaxHR, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "Age vs Maximum Heart Rate",x="Age",y="HR",color ="HeartDisease")
    print(vsmaxhrPlot.plot)
  })
  #Age Vs RestingBP   #positive
  output$vsrestingbpPlot <- renderPlot({
    vsrestingbpPlot.plot <- ggplot(heart, mapping = aes(x=alldata$Age, y=alldata$RestingBP, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "Age vs RestinBP",x="Age",y="RestingBp",color ="HeartDisease")
    print(vsrestingbpPlot.plot)
  })
  #Age vs Cholesterol neutral
  output$vscholesterolPlot <- renderPlot({
    vscholesterolPlot.plot <- ggplot(heart, mapping = aes(x=alldata$Age, y=alldata$Cholesterol, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "Age vs Cholesterol",x="Age",y="Cholesterol",color ="HeartDisease")
    print(vscholesterolPlot.plot)
  })
  #RestingBP vs Cholesterol
  output$vsrestingbpPlot2 <- renderPlot({
    vsrestingbpPlot2.plot <- ggplot(heart, mapping = aes(x=alldata$RestingBP, y=alldata$Cholesterol, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "RestingBP vs Cholesterol",x="RestingBP",y="Cholesterol",color ="HeartDisease")
    print(vsrestingbpPlot2.plot)
  })
  #MaxHR VS Cholesterol  positive
  output$vsmaxhrPlot2 <- renderPlot({
    vsmaxhrPlot2.plot <- ggplot(heart, mapping = aes(x=alldata$MaxHR, y=alldata$Cholesterol, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "MaxHR VS Cholesterol",x="MaxHR",y="Cholestrol",color ="HeartDisease")
    print(vsmaxhrPlot2.plot)
  })
  #FastingBS vs Cholesterol
  output$vsfastingbsPlot <- renderPlot({
    vsfastingbsPlot.plot <- ggplot(heart, mapping = aes(x=alldata$FastingBS, y=alldata$Cholesterol, color=as.logical(alldata$HeartDisease))) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      labs(title = "FastingBS VS Cholesterol",x="FastingBS",y="Cholestrol",color ="HeartDisease")
    print(vsfastingbsPlot.plot)
  })
  
}


# Run the application
shinyApp(ui = ui, server = server)
