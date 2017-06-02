+++
Categories = ["Development", "GoLang"]
Description = ""
Tags = ["Development", "golang"]
date = "2017-02-02T17:59:21-07:00"
menu = "main"
title = "Capstone Part4"

+++

### -Capstone Project Part4-

Rough Draft

A Re-Engineering of the Cancer Research Web Application PatientView.

The project is over! After hundreds of hours of research, late-night coding binges, frustration, and triumphs my team delivered the Re-Engineered PatientView to the Mayo Clinic with ~90% of the origionally planned items implemented. The project consists of well over ten thousand lines of `Python` and `JavaScript` code, `HTML`, and `CSS`. I am unable to share the github repo as the product belongs to the Mayo Clinic for their internal use only. As the project progressed we discovered that some of the initial goals were out of the project's scope or not possible due to technological or time constraints. However, we are extremely proud of the work we did and were able to accomplish the vast majority of the Mayo Clinic's requirements. 

<br>

When the user navigates to the PatientView page they are asked to sign in:

![GAuth1](/images/pv_4/google_auth1.jpg) 

If they enter the incorrect information or do not have the proper credentials they willl see this:

![GAuth2](/images/pv_4/google_auth2.jpg) 

If login is successful the user is taken to the landing page. From there they can access the various features of PatientView. The web application serves as a tool for cancer researchers to enter patient data and quickly gather information, run tests, compare patient outcomes, etc. 

Here's an example of one of PatientView's Create Pages:

![ClinicalStudy](/images/pv_4/create_clinicalstudy.jpg) 

All of the pages have complete error checking and input validation. For example, if a field isn't selected the user will be alerted. If the 'In Progress' box is checked then the 'End Date' will be reset and disabled and the completed box will be disabled. This is because it does not make sense to both be in progress and completed at the same time. 

Here is the `Python` code behind the page:

![ClinicalStudyCode](/images/pv_4/create_clinicalstudy_code.jpg) 

This is a portion of the project that I spent extensive time with. Here is a table showing what all was required for a 'Create Page':

![CodeStack](/images/pv_4/codestack.jpg) 

There are numerous ways to query a patient. One is by using the search bar. The search bar has autocomplete functionaly and also supports AJAX dropdown with HTML5:

![Search](/images/pv_4/searchbar.jpg) 

When a patient is found the user will see something like this:

![FoundPatient](/images/pv_4/patientfound.jpg) 

Here are some comparisons of the origional and new PatientView:

![og](/images/pv_4/original_pv.jpg) 
![new](/images/pv_4/new_pv.jpg) 
![og1](/images/pv_4/original1_pv.jpg) 
![new1](/images/pv_4/new1_pv.jpg) 

<br>

PatientView: At times it was really rewarding, and at times it was fully frustrating. However, the net of all my experiences has been positive and I am grateful that I had the opportunity to work with other good humans to create a product that serves the noble cause of cancer research. 