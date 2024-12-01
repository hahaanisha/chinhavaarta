# Chinhavarta - Where Signs Speak Louder than Words
<img src="readme images/logo.png" alt="Logo" width="200" />
Chinhavarta is an innovative mobile application designed to bridge the communication gap for people with hearing impairments by enabling seamless interaction using Indian Sign Language (ISL). The app focuses on providing an accessible platform for users to learn, practice, and understand ISL gestures.

---

## **Table of Contents**
1. [Overview](#overview)
2. [Key Features](#key-features)
3. [Video Demonstration](#video-demonstration)
4. [Screenshots](#screenshots)
    - [Successful Mail Notifications](#successful-mail-notifications)
    - [Failed Attempts](#failed-attempts)
5. [Kestra Implementation](#kestra-implementation)
6. [Future Enhancements](#future-enhancements)

---

## **Overview**
Indian Sign Language (ISL) datasets and applications are not as widely used or supported as American Sign Language (ASL). Chinhavarta is a pioneering effort to promote the learning and adoption of ISL through AI-powered detection, a gesture dictionary, and community-building features.

---

<img src="readme images/flow.png" alt="UI" width="700" height ="500">

## **Key Features**
1. **Camera Detection**: Detects ISL gestures in real-time.  
2. **Dictionary**: A curated ISL dictionary with letters and their respective words (sourced from [indiansignlanguage.org](http://indiansignlanguage.org)).  
3. **Community Page**: Locate deaf organizations near you.  
4. **Interactive Quiz**: Test your knowledge of ISL gestures with real-time feedback.  
5. **Feedback System**: Contribute gestures and provide feedback via an intuitive feedback page.

- Chinhavaarta UI: 
<img src="readme images/homepage.png" alt="UI" width="300" height ="500">
- Dataset collected by us:
<img src="readme images/dataset.png" alt="UI" width="500" height ="300">
- Model Results:
<img src="readme images/model.png" alt="UI" width="300" height ="500">

---

## **Video Demonstration**
[Click to Watch the Demo](https://www.youtube.com/watch?v=Qbsd0wOLQYE)

---

## **Screenshots**

### **Successful Mail Notifications**
Below are examples of emails successfully sent after quiz attempts and feedback submissions:
   <img src="readme images/quiz.jpeg" alt="UI" width = "500" height = "300">

 <img src="readme images/feedback.jpeg" alt="UI" width = "500" height = "300">
---

### **Failed Attempts**
The following section captures failed attempts in Kestra, along with a brief explanation of the issue:

1. **Using Kestra for Model Training**
     <img src="readme images/samplekestra.jpeg" alt="UI" width = "500" height = "300">
    - We tried using kestra to continously train the model with the images recieved thus automating the training process, but we faced some errors there`.
    - We also tried to integrate Kestra in the deployment phase
      
**Our Main aim was to use kestra as our backbone for backend**

2. **Extra attempts**
    -  <img src="readme images/samplekestra1.jpeg" alt="UI" width = "500" height = "300">
    - While exploring the amazing plugins of kestra, we developed a custom workflow which automates the process of sending POST requests

---

## **Kestra Implementation**
Kestra automates backend processes using predefined plugins. Here's how we used Kestra for Chinhavarta:

1. **io.kestra.plugin.notifications.mail.MailSend**:
   - Sends emails for quiz score updates and feedback acknowledgments.
   - Uses Gmail's SMTP server for email delivery.

2. **io.kestra.plugin.core.http.Trigger**:
   - Sets up HTTP endpoints (`/trigger-feedback` and `/trigger-quiz`) to receive data and initiate tasks.

**Example Workflow**:
- Data (email, gesture/score) is submitted to the endpoint.
- Kestra triggers the task and sends an email with the required details.

**Screenshot of Workflow Setup**:  
 - <img src="readme images/feedback_workflow.jpeg" alt="UI" width = "500" height = "300">
 - <img src="readme images/quiz_workflow.jpeg" alt="UI" width = "500" height = "300">
 - <img src="readme images/dashboard.jpeg" alt="UI" width = "500" height = "300">

---

## **Future Enhancements**
- Expanding the ISL gesture dataset for more robust recognition.
- Enhancing gesture accuracy with deep learning models.
- Adding a video tutorial section for ISL beginners.
- Integration with regional sign languages to support broader accessibility.

---

**Chinhavarta** is a step towards making communication more inclusive. Your feedback is invaluable—contribute to our gesture library and help us grow!  

---
Made with ❤️ by [Tejas Gadge](https://github.com/tejasgadge2504) & [Anisha Shankar](https://github.com/hahaanisha)

