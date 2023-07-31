Relay MDPT Position Submission

For the following data submissions I wanted to create a small README outlining the steps of the process for creating the data required by this task.

First and foremost I want to address the duplicate records from the dataset I created.  I felt that in the process of the task, these student I.D.s would need to be further investigated, and looking at their records it appeared to be a few students enrolled then renerolled, and another few whose school codes returned a number of results from the U.S. Department of Education’s API.  In both cases, I think a conversation about a students status, especially with the little information I was given.  In both cases for the actual "Deliverable" i.e. the Excel and the Visualization the records are only recorded once, however the Access / Database would still be able to make adjustments as we deemed after the said discussion. 

In regards to the records with multiple returned school codes i.e. the Ponce Health Sciences University.  We would need to investigate which campus specifically the student attended, then adjust the record as necessary. In this case I left only the Ponce Health Sciences University record for the students.

In my work I also noticed that students who have "re-enrolled" pop up as duplicates if not properly dealt with in the query, due to the fact that they have two start_dates and multiple enrollment status.   Although their responses are not changed, I think that there is significant data that can be gleaned from the responses of this specific group.  I think that although the prompt wants "clean data" I think it would be important to add some type of new signifier of this select group as their opinions can give insight to a unique grouping of students.  In this case, I left only the most recent start time in the excel and visualization. 


In order to complete the project I first used the attached python file to scrape the U.S. Department of Education’s API
<br />
<link>https://github.com/quiltyy/Relay/blob/main/MD%20PT.%20Python%20Scrape%2007.28.23.py</link>
<br />
Once I attained this data I placed it into a Microsoft SQL Server where I then ran the following code 
<br />
<link>https://github.com/quiltyy/Relay/blob/main/MD%20PT.%20Query%2007.28.23.sql</link>
<br />
In order to create a list of "unique" students.  I have attached a copy of the database as an Access file here
<br />
<link>https://github.com/quiltyy/Relay/blob/main/Relay.accdb</link>
<br />
<br />
You can view the results of the query under Relay Results, but I also created a verification query that searches for any repeated studentid's and returns their values for further examination which identified the students and then reviewed the records. 
Finally I placed the data in a simple PowerBI showing the responses for each survey question and added a few filters for investigation by the customers.  The visualizations all only record one response per unique student ID meaning that although I left a few duplicate records for review in the original data, the end-users reports will not be effected regardless of our decisions on processing the students. 

