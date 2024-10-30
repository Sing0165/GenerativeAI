library(shiny)
library(DT)
library(plotly)

# Define UI
ui <- fluidPage(
  tags$style(HTML("
    body {
        background-color: #b04a5e;
        font-family: 'Times New Roman', serif;
        color: #333333;
        font-size: 18px;
    }
    .navbar {
        background-color: #841617;
    }
    .navbar a {
        color: #ffffff !important;
    }
    .container {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        color: #343a40;
    }
    h1, h3, h4 {
        color: #000000; 
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
    }
    .btn {
        width: 100%;
        margin: 10px 0;
        font-size: 16px;
        border-radius: 20px;
    }
    .footer {
        text-align: center;
        padding: 20px;
        color: #ffffff;
    }
    .tab-content {
        margin-top: 20px;
    }
    .welcome-box, .registration-box, .header-box {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        margin-bottom: 20px;
    }
    .welcome-box h4, .registration-box h3, .header-box h1 {
        text-align: center;
        color: #000;
        padding: 10px;
        background-color: #841617;
        color: #ffffff;
        border-radius: 10px;
    }
    .pink-box {
        background-color: #f8d7da;  
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    .chat-box {
        max-height: 300px;
        overflow-y: auto;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #fff;
    }
    .user-message {
        color: blue;
        font-weight: bold;
        margin: 5px 0;
    }
    .bot-message {
        color: green;
        font-weight: bold;
        margin: 5px 0;
    }
  ")),
  
  titlePanel("Future Engineer Assistant - ShinyGeminiPro App"),
  
  # Registration Page
  conditionalPanel(
    condition = "!output.registered",
    fluidPage(
      titlePanel(tags$div(class = "header-box", "🔐 Register to Access Future Engineer Assistant")),
      sidebarLayout(
        sidebarPanel(
          tags$div(class = "registration-box",
                   textInput("first_name", "First Name", placeholder = "Enter your first name..."),
                   textInput("last_name", "Last Name", placeholder = "Enter your last name..."),
                   dateInput("dob", "Date of Birth", format = "mm/dd/yyyy"),
                   textInput("username", "Username", placeholder = "Enter your username..."),
                   textInput("school", "School", placeholder = "Enter your school..."),
                   selectInput("year", "Year", choices = c("Freshman", "Sophomore", "Junior", "Senior")),
                   textInput("email", "Email ID", placeholder = "Enter your email..."),
                   textInput("phone", "Phone Number", placeholder = "(000) - 000 0000"),
                   radioButtons("gender", "Gender Identity?", choices = c("Male", "Female", "Trans Male/Trans Man", "Trans Female/Trans Woman", "Genderqueer/Gender Non-Conforming", "Prefer to self-describe, please specify:", "Prefer not to say")),
                   checkboxGroupInput("race", "Race/Ethnicity (Please select all that apply):", choices = c("American Indian or Alaska Native", "Asian", "Black or African American", "Hispanic or LatinX", "Native Hawaiian or Other Pacific Islander", "White")),
                   passwordInput("reg_password", "Password"),
                   passwordInput("reg_password_reenter", "Re-enter Password"),
                   checkboxInput("terms", "I agree to the Terms and Condition and Privacy Policy"),
                   actionButton("registerBtn", "Register"),
                   actionButton("nextBtnReg", "Next", class = "btn-primary")
          )
        ),
        mainPanel(
          tags$div(class = "registration-box",
                   h3("Welcome to Future Engineer Assistant! Please register to proceed.")
          )
        )
      )
    )
  ),
  
  # Main Application - Visible After Registration
  conditionalPanel(
    condition = "output.registered",
    tabsetPanel(
      tabPanel("Home",
               fluidPage(
                 titlePanel(tags$div(class = "header-box", "Welcome to the Future Engineer Assistant!")),
                 tags$div(class = "welcome-box",
                          h4("Developed by: Akshay Singh and Kaustuabh Pandit"),
                          h4("Mentor: Dr. Javeed Kittur"),
                          hr(),
                          h3("Purpose"),
                          p("This application leverages voice recognition technology to facilitate a unique interaction with a chatbot designed specifically for engineering students."),
                          p("The main goal of this project is to provide an intuitive and interactive platform for students to engage with a virtual assistant that can help them explore career paths, salary predictions, and more."),
                          hr(),
                          h3("Instructions"),
                          tags$ol(
                            tags$li("Click 'Start Recording' to capture your voice."),
                            tags$li("Once you finish speaking, click 'Stop Recording.'"),
                            tags$li("Your voice input will be transcribed and displayed in the chat history."),
                            tags$li("You can also type your questions or commands directly into the text box."),
                            tags$li("Use the API Key tab to input your API key for chatbot responses."),
                            tags$li("Explore the Salary Prediction tab to estimate salaries based on your chosen engineering pathway."),
                            tags$li("Visit the Employment Prediction tab to determine your probability of employment based on your GPA, Major, and Degree.")
                          ),
                          hr(),
                          h3("Each Tab Explained"),
                          p("Each tab is designed to help you with specific functionalities:"),
                          tags$ul(
                            tags$li("Home: Overview of the application and general instructions."),
                            tags$li("API Key: Input your API key to enable chatbot responses. You will receive a confirmation message once saved."),
                            tags$li("Voice Interaction: Record your voice or type your messages to interact with the chatbot, which will log all interactions for reference."),
                            tags$li("Salary Prediction: Select your engineering pathway and experience to predict potential salary. Results will be shown in a pop-up."),
                            tags$li("Employment Prediction: Input your GPA, Major, and Degree to see your employment probability. This section includes visualizations to help understand the data.")
                          ),
                          hr(),
                          h3("Getting Started"),
                          p("To begin, navigate to the tabs on the left and follow the instructions to make the most of the chatbot's capabilities!"),
                          p("Explore each section thoroughly to understand how the chatbot can assist you with your academic and career-related inquiries.")
                 )
               )
      ),
      tabPanel("API Key",
               sidebarLayout(
                 sidebarPanel(
                   textInput("new_apikey", "Enter New API Key"),
                   actionButton("saveApiKeyBtn", "Save API Key"),
                   actionButton("nextBtnApiKey", "Next", class = "btn-primary")
                 ),
                 mainPanel(
                   tags$div(class = "pink-box",
                            tags$h4("Manage Your API Key"),
                            tags$p("Enter your API key and click 'Save' to store it. A confirmation will appear if successful."),
                            tags$h5("Instructions:"),
                            tags$p("1. Obtain your API key from the provider."),
                            tags$p("2. Enter the key in the text box."),
                            tags$p("3. Click 'Save' to store the key for your chatbot interactions.")
                   )
                 )
               )
      ),
      tabPanel("Try Gemini Pro (Text & Vision Model)",
               sidebarLayout(
                 sidebarPanel(
                   radioButtons("input_method", "Choose Input Method:",
                                choices = list("Text" = "text", "Audio Recording" = "audio"),
                                inline = TRUE),
                   tags$hr(),
                   conditionalPanel(
                     condition = "input.input_method == 'text'",
                     textAreaInput("userInput", "Ask a Question to the Chatbot", placeholder = "Type your message here...", rows = 3)
                   ),
                   conditionalPanel(
                     condition = "input.input_method == 'audio'",
                     tags$h5("Audio input selected. Click 'Start Recording' to begin."),
                     actionButton("startRecording", "Start Recording"),
                     actionButton("stopRecording", "Stop Recording")
                   ),
                   tags$hr(),
                   actionButton("generateResponseBtn", "Generate Response🔮"),
                   tags$h4("Answer the Chatbot's Questions"),
                   textAreaInput("chatbotAnswerInput", "Your Answer", placeholder = "Type your answer here...", rows = 3),
                   actionButton("submitAnswerBtn", "Submit Answer"),
                   actionButton("nextBtnGeminiPro", "Next to Salary Prediction", class = "btn-primary")
                 ),
                 mainPanel(
                   tags$div(class = "pink-box",
                            tags$div(class = "chat-box", 
                                     uiOutput("chatOutput")
                            ),
                            textOutput("audioMessage"),
                            plotlyOutput("careerChart")
                   )
                 )
               )
      ),
      tabPanel("Salary Prediction",
               sidebarLayout(
                 sidebarPanel(
                   h4("Instructions"),
                   p("In this section, we'll guide you through the salary prediction process."),
                   p("1. Select your job title and experience level."),
                   p("2. Based on your selections, you'll be asked follow-up questions."),
                   p("3. After providing the necessary information, you'll see your predicted salary."),
                   hr(),
                   selectInput("job_title", "Select Job Title", choices = unique(data$job_title)),
                   selectInput("experience", "Select Experience Level", choices = unique(data$experience_level)),
                   actionButton("askSalaryQuestions", "Next"),
                   actionButton("nextBtnSalary", "Next", class = "btn-primary")
                 ),
                 mainPanel(
                   tags$div(class = "pink-box",
                            DTOutput("salaryResponsesTable"),
                            textOutput("salary_response"),
                            textOutput("chatbotSalaryResponse"), 
                            plotlyOutput("salary_histogram"),
                            plotlyOutput("salary_boxplot")
                   )
                 )
               )
      )
    )
  ),
  
  # JavaScript for text-to-speech and audio recording
  tags$script(HTML("
    Shiny.addCustomMessageHandler('speak', function(message) {
      var msg = new SpeechSynthesisUtterance(message);
      window.speechSynthesis.speak(msg);
    });

    let mediaRecorder;
    let audioChunks = [];
    
    document.querySelector('#startRecording').onclick = () => {
      navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
        mediaRecorder = new MediaRecorder(stream);
        mediaRecorder.start();
        mediaRecorder.ondataavailable = event => {
          audioChunks.push(event.data);
        };
      });
    };

    document.querySelector('#stopRecording').onclick = () => {
      mediaRecorder.stop();
      mediaRecorder.onstop = () => {
        const audioBlob = new Blob(audioChunks);
        const reader = new FileReader();
        reader.onloadend = () => {
          const base64data = reader.result;
          Shiny.setInputValue('audioData', base64data);
        };
        reader.readAsDataURL(audioBlob);
        audioChunks = [];
      };
    };

    let recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
    recognition.onresult = function(event) {
      const transcript = event.results[0][0].transcript;
      Shiny.setInputValue('userInput', transcript);
    };
    
    document.querySelector('#startRecording').onclick = function() {
      recognition.start();
    };
  "))
)
# Define server logic
server <- function(input, output, session) {
  chat_history <- reactiveVal(data.frame(Role = character(), Message = character(), stringsAsFactors = FALSE))
  audio_message <- reactiveVal("")
  registered <- reactiveVal(FALSE)
  salary_responses <- reactiveVal(data.frame(Job_Title = character(), Experience_Level = character(), Response = character(), stringsAsFactors = FALSE))
  
  career_questions <- c(
    "What is your preferred engineering discipline?",
    "What is your ideal work environment?",
    "What skills do you think are most important for your career?",
    "What are your long-term career goals?",
    "What type of projects excite you the most?"
  )
  current_question_index <- reactiveVal(1)
  answer_received <- reactiveVal(FALSE)
  
  observeEvent(input$registerBtn, {
    # Add registration logic here if needed
    registered(TRUE)
  })
  
  output$registered <- reactive({ registered() })
  outputOptions(output, "registered", suspendWhenHidden = FALSE)
  
  observeEvent(input$saveApiKeyBtn, {
    if (nzchar(input$new_apikey)) {
      showModal(modalDialog(
        title = "API Key Saved",
        "Your API key has been saved successfully.",
        easyClose = TRUE,
        footer = NULL
      ))
      askCareerQuestions()
    } else {
      showModal(modalDialog(
        title = "Error",
        "Please enter a valid API key.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  askCareerQuestions <- function() {
    if (current_question_index() <= length(career_questions)) {
      question <- career_questions[current_question_index()]
      chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = question, stringsAsFactors = FALSE)))
      current_question_index(current_question_index() + 1)
      answer_received(FALSE)
    } else {
      chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = "Now you can ask me any questions you may have.", stringsAsFactors = FALSE)))
    }
  }
  
  observeEvent(input$generateResponseBtn, {
    req(input$userInput)
    user_text <- input$userInput
    response <- generateContent(user_text, api_key = input$new_apikey)
    
    chat_history(rbind(chat_history(), data.frame(Role = "User", Message = user_text, stringsAsFactors = FALSE)))
    chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = response, stringsAsFactors = FALSE)))
    
    session$sendCustomMessage(type = 'speak', message = response)
  })
  
  observeEvent(input$submitAnswerBtn, {
    req(input$chatbotAnswerInput)
    answer_text <- input$chatbotAnswerInput
    
    chat_history(rbind(chat_history(), data.frame(Role = "User", Message = answer_text, stringsAsFactors = FALSE)))
    chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = paste("You answered:", answer_text), stringsAsFactors = FALSE)))
    
    answer_received(TRUE)
    askCareerQuestions()
  })
  
  output$chatOutput <- renderUI({
    chat_data <- chat_history()
    chat_list <- lapply(1:nrow(chat_data), function(i) {
      message_class <- ifelse(chat_data$Role[i] == "User", "user-message", "bot-message")
      tags$div(class = message_class, paste0(chat_data$Role[i], ": ", chat_data$Message[i]), style = "margin: 10px 0; line-height: 1.5;")
    })
    do.call(tagList, chat_list)
  })
  
  observeEvent(input$askSalaryQuestions, {
    job_title <- input$job_title
    experience_level <- input$experience
    
    if (!is.null(job_title) && !is.null(experience_level)) {
      user_question <- paste("What is your expected salary range for a", job_title, "with", experience_level, "experience?")
      response <- generateContent(user_question, api_key = input$new_apikey)
      chat_history(rbind(chat_history(), data.frame(Role = "User", Message = user_question, stringsAsFactors = FALSE)))
      chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = response, stringsAsFactors = FALSE)))
      
      current_responses <- salary_responses()
      salary_responses(rbind(current_responses, data.frame(Job_Title = job_title, Experience_Level = experience_level, Response = response, stringsAsFactors = FALSE)))
      
      session$sendCustomMessage(type = 'speak', message = response)
    }
  })
  
  output$salaryResponsesTable <- renderDT({
    salary_responses()
  })
  
  observeEvent(input$nextBtnGeminiPro, {
    updateTabsetPanel(session, "tabs", selected = "Salary Prediction")
    showModal(modalDialog(
      title = "Salary Prediction Tab Instructions",
      "1. Select your job title, experience level, and provide additional information as prompted.\n
      2. Click 'Next' to see your predicted salary and distribution.\n
      3. Visualizations will help you understand the salary landscape.",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$userInput, {
    if (current_question_index() > 1 && !answer_received()) {
      response <- input$userInput
      chat_history(rbind(chat_history(), data.frame(Role = "User", Message = response, stringsAsFactors = FALSE)))
      
      chat_history(rbind(chat_history(), data.frame(Role = "Bot", Message = paste("You answered:", response), stringsAsFactors = FALSE)))
      answer_received(TRUE)
      askCareerQuestions()
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


