# PATIENT-FEEDBACK-TRACKING-SYSTEM

### PROJECT TITLE : Patient Feedback Tracking System
### NAME : MUCYO Fabrice
### ID : 27823
### COURSE : Database Development with PL/SQL


----
## PHASE 1: 
## PROBLEM STATEMENT
Hospitals use paper forms for patient feedback which get lost and provide no analytics and this digital system stores all feedback securely, enforces business rules automatically and provides actionable insights for service improvement and also this system will help to secure data like for the old ways some one who is not even registered as Patient could give a feedback without getting service and This system will also help the Hospital to receive Feedback from Registerd Patients who receive the service

### KEY OBJECTIVE
1. ✅ Digitize patient feedback collection
2. ✅ Implement business rules (no weekday/holiday changes)
3. ✅ Create comprehensive audit trail
4. ✅ Generate automated reports and analytics for every department
5. ✅ Build production ready PL/SQL database solution

### LINKS TO DOCUMENTATION
1. <a href="Documentation/data_dictionary.md">Data Dictionary</a>
2. <a href="Documentation/architecture.md">System Architecture</a>
3. <a href="Documentation/designing_decisions.md">Designing Decisions</a>
4. <a href="Business Intelligence/bi_requirements.md">BI Requirements</a>
5. <a href="Business Intelligence/kpi_definitions.md">KPI Definition</a>

## PHASE 2:
## BUSINESS PROCESS MODELING (BPMN)

<img src="Screenshots/Database_objects/Patient Feedback Tracking System BPMN.png">

# Patient Feedback Tracking System BPMN

## Process Purpose
This BPMN diagram shows how a hospital handles patient feedback from start to finish it ensures feedback is collected, reviewed, stored and reported in a structured way

## Main Elements of the Diagram

### **1. Start to Decision (Left Side)**
The process begins when a patient gives feedback. First, the system checks the patient's ID to make sure it's valid then it asks: "Is this feedback about a specific treatment?"
- **Yes → Goes to** "Receiver Medical Service"
- **No → Goes to** "Process Feedback"

This decision point helps route feedback to the right place

### **2. Processing Feedback (Middle)**
- **Receiver Medical Service:** If feedback is about a treatment the medical team receives it
- **Process Feedback:** General feedback is handled here
- **Another Decision:** "Is there any other treatment to review?"
  - **Yes →** Loops back to "Receiver Medical Service"
  - **No →** Moves forward

This loop allows patients to give feedback on multiple treatments at once

### **3. Saving Feedback**
After feedback is processed:
- **Update Feedback Status:** Marks it as reviewed
- **Log Feedback Change:** Keeps a record of what was done
- **Store Feedback in Database:** Saves it permanently

### **4. Management Reports (Bottom)**
Finally:
- **Generate Department Statistic:** Creates numbers and trends for each department
- **Generate Feedback Report:** Makes official reports
- **End:** Process Complete

## Who Does What
- **Patients** start the process
- **Medical Staff** review treatment related feedback
- **System or Admin** update, log, store and report

## Why This System Works
- It organizes feedback so nothing is missed
- It connects patients directly to their care teams when needed
- It saves everything securely
- It creates useful reports to help the hospital improve

## PHASE 3:
## LOGICAL DATABASE DESIGN (ER DIAGRAM)


