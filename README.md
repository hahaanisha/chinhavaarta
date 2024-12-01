# Chinhavarta - Where Signs Speak Louder than Words
<img src="logo.png" alt="Logo" width="200" />
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

## **Key Features**
1. **Camera Detection**: Detects ISL gestures in real-time.  
2. **Dictionary**: A curated ISL dictionary with letters and their respective words (sourced from [indiansignlanguage.org](http://indiansignlanguage.org)).  
3. **Community Page**: Locate deaf organizations near you.  
4. **Interactive Quiz**: Test your knowledge of ISL gestures with real-time feedback.  
5. **Feedback System**: Contribute gestures and provide feedback via an intuitive feedback page.

---

## **Video Demonstration**
[Click to Watch the Demo](#) (Replace `#` with your hosted video link.)

---

## **Screenshots**

### **Successful Mail Notifications**
Below are examples of emails successfully sent after quiz attempts and feedback submissions:

1. **Quiz Score Notification:**
    ![Quiz Email](screenshots/quiz_email_success.png)

2. **Feedback Acknowledgment:**
    ![Feedback Email](screenshots/feedback_email_success.png)

---

### **Failed Attempts**
The following section captures failed attempts in Kestra, along with a brief explanation of the issue:

1. **Failed to Trigger Feedback Task:**
    - **Screenshot**: ![Trigger Failure](screenshots/trigger_failure.png)
    - **Reason**: Incorrect input mapping for `feedback`.

2. **SMTP Connection Error:**
    - **Screenshot**: ![SMTP Error](screenshots/smtp_error.png)
    - **Reason**: Invalid SMTP credentials used during testing.

3. **Endpoint Misconfiguration:**
    - **Screenshot**: ![Endpoint Failure](screenshots/endpoint_failure.png)
    - **Reason**: Misconfigured `/trigger-feedback` URI during setup.

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
![Kestra Workflow](screenshots/kestra_workflow.png)

---

## **How to Use**
1. Clone the repository:
    ```bash
    git clone https://github.com/your-repo/chinhavarta.git
    cd chinhavarta
    ```
2. Configure SMTP credentials for email notifications:
   - Update `username` and `password` in the Kestra workflow files.
3. Launch the app and explore features:
   - Gesture detection
   - ISL dictionary
   - Community connections
   - Quiz and feedback sections

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
