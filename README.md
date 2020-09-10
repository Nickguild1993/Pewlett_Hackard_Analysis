# Pewlett Hackard Analysis.


## Overview of the analysis

The purpose of this analysis was twofold: firstly, to further understand the magnitude of the upcoming "silver tsunami" on a departmental level at Pewlett Hackard, and secondly, to begin fleshing out a mentorship program that would allow for a smoother transition as the younger replacements take over for the employees that're aging out.  By breaking down the upcoming rash of retirements by department, Pewlett Hackard (PH) will be able to know not only skillsets they need to look for in new hires, but also which departments are going to have the most turnover and plan accordingly.  Building the framework for a mentorship program will allow PH to ensure that their various departments don't have massive disruptions caused by a lack of familiarity of PHs systems when the new incoming workforce replaces the old guard. 

## Results Section

- As the table below shows, the largest exodus of retiring employees will be Senior Engineers and Senior Staff, with 29,414 and 29,254 employees up for retirement, respectively.

![ALT_TEXT](https://github.com/Nickguild1993/Pewlett_Hackard_Analysis/blob/master/retiring_titles_C7_SQL.png)

- As the table below shows, many of the outgoing employees have been internally promoted- for example, Sumant Peac started as an assistant engineer back in 1985 and worked his way up to senior engeinner- the position he holds today.  What this means is that PH must be confident in their ability to teach their employees new tasks and responsibilities if they're comfortable internally promoting instead of looking at outside canididates who may be moving laterally instead of upwards. Since many of these retiring employees have experience at multiple levels within the same field, they should make excellent candidates to mentor their replacements.

- Since the retiring employees have inherently been at PH for a long time, this wave of retirements will affect upper level positions within the various departments the most.  That means that PH will have to be very careful to make sure that either people retire in groups, so as not to gut entire departments of their senior level leadership, or absolutely make sure those employees who're replacing the outgoing employees have been trained up enough to immediately jump in and handle the tasks that their predecessors were routinely managing.

![ALT_TEXT](https://github.com/Nickguild1993/Pewlett_Hackard_Analysis/blob/master/retirement_titles_C7_SQL.png)

- The table below, which includes all eligible employees for the mentorship program, has 1,549 candidates. Given that there are far more retiring employees than candidiates who are considered eligible for the mentorship program, there will be a serious short fall of available mentors to mentees.  

![ALT_TEXT](https://github.com/Nickguild1993/Pewlett_Hackard_Analysis/blob/master/mentorship_elig_C7_SQL.png)

## Summary Section

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

- There are going to be 90,398 roles needing to be filled by the upcoming "silver tsunami".  Of those, outgoing senior level engineers and staff comprise 57,668 of those roles- these retirements are going to have to be managed very carefully to not avoid a potentially crippling brain drain on the company.  

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?  

- Not even close.  Using the query SELECT COUNT (emp_no) FROM mentorship_eligibility; there are 1,549 mentor canidates avaiable.  Then, looking at the total amount of upcoming retirements by using the query SELECT COUNT (emp_no) FROM unique_titles; there are 90,398 employees up for imminent retirement. Assuming you ideally want a 1 : 1 of mentors to mentees, PH is going to be short 88,849 mentors.  

### Additional insight into the upcoming "silver tsunami"

- If you run the query SELECT COUNT (emp_no) FROM unique_titles / SELECT COUNT (emp_no) FROM employees;  you'll find that .301, or 30% of all employees at PH are going to immeniently retire as part of this wave.  That is concerning, to say the least.  In order to ensure that PH is able to continue functioning at a high level, this upcoming staffing overall needs to be front and center of the companies plans.

- Below is a table breaking down the average salaries of outgoing employees for each department.  The title with the highest average salary is "manager" with $59,612 but as shown above, there are only 2 departing employees who are listed as managers under their title.  However, the title with the second highest average salary is "senior staff" with $58,411 and PH has 29,254 employees up for retirement under that designation.  PH has an opportunity to save money on salary going forward, assuming that new employees with the same title aren't paid as much as more tenured employees in the same role.  

- Additionally, it's strange that on average, senior engineers make less than both engineers and assistant engineers, given that those jobs are below that of a senior level engineer.

![ALT_TEXT](https://github.com/Nickguild1993/Pewlett_Hackard_Analysis/blob/master/rounded_retiring_salaries_C7_SQL.png)
