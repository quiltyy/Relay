SELECT ir_powerbi.dbo.[Relay.dbo_StudentFact].studentid,
    degree,
    campus,
    sex,
    age,
    CASE
WHEN [ir_powerbi].[dbo].[Relay.dbo_StudentFact].race not in ('White') THEN 'Yes'
WHEN [ir_powerbi].[dbo].[Relay.dbo_StudentFact].ethnicity = 'Hispanic/Latinx' THEN 'Yes'
ELSE 'No'
END AS 'BIPOC',
    [ir_powerbi].[dbo].[Relay.dbo_EnrollmentFact].enrollmentstatus,
    [ir_powerbi].[dbo].[Relay.dbo_EnrollmentFact].startdate,
    [ir_powerbi].[dbo].[Relay.dbo_EnrollmentFact].enddate,
    q1.response as 'I am satisfied with my graduate schools instruction',
    q2.response as 'I am satisfied with my graduate schools operations',
    q3.response as 'I am satisfied with my graduate schools tuition',
    q4.response as 'I am satisfied with my graduate schools communication',
    c1.coursegrade as 'Lesson Planning',
    c2.coursegrade as 'Classroom Culture',
    c3.coursegrade as 'Instruction',
    c4.coursegrade as 'Assessing Student Learning',
    [Relay.SchoolInformation].school#name as 'School Name',
    [Relay.SchoolInformation].id as 'Unit ID',
    [Relay.SchoolInformation].fed_sch_cd as 'Federal School Code',
    [Relay.SchoolInformation].school#city as 'City',
    [Relay.SchoolInformation].school#state as 'State',
    [Relay.SchoolInformation].school#title_iv#eligibility_type as'Title IX Type',
    [Relay.SchoolInformation].school#title_iv#approval_date as 'Title IX Approval Date',
    [Relay.SchoolInformation].school#accreditor as 'Accreditor',
    CASE
WHEN [Relay.SchoolInformation].school#ownership = 1 THEN 'Public'
WHEN [Relay.SchoolInformation].school#ownership = 2 THEN 'Private Non-Profit'
WHEN [Relay.SchoolInformation].school#ownership = 3 THEN 'Private For-Profit'
ELSE 'Unknown'
END AS 'Governance Structure',
    [Relay.SchoolInformation].[2019#student#size] as '2019 Total Enrollment',
    [Relay.SchoolInformation].[2019#student#retention_rate#four_year#full_time] as 'Retention rate First Time Full-Time 4 Years',
    [Relay.SchoolInformation].[2019#student#retention_rate#lt_four_year#full_time] as 'Retention rate First Time Full-Time at Less Than 4 Years'

FROM ir_powerbi.dbo.[Relay.dbo_StudentFact]
    LEFT JOIN [ir_powerbi].dbo.[Relay.dbo_EnrollmentFact] on ir_powerbi.dbo.[Relay.dbo_StudentFact].studentid = [ir_powerbi].dbo.[Relay.dbo_EnrollmentFact].studentid
    LEFT JOIN [ir_powerbi].[dbo].[Relay.dbo_StudentEducationHistoryFact] on [ir_powerbi].[dbo].[Relay.dbo_StudentEducationHistoryFact].studentid = [ir_powerbi].dbo.[Relay.dbo_EnrollmentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid, ir_powerbi.dbo.[Relay.dbo_ResponseDimension].response
    FROM [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact]
        LEFT JOIN ir_powerbi.dbo.[Relay.dbo_ResponseDimension] ON ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
    WHERE ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
        AND [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].questionid =1 ) q1 on q1.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid, ir_powerbi.dbo.[Relay.dbo_ResponseDimension].response
    FROM [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact]
        LEFT JOIN ir_powerbi.dbo.[Relay.dbo_ResponseDimension] ON ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
    WHERE ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
        AND [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].questionid =2 ) q2 on q2.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid, ir_powerbi.dbo.[Relay.dbo_ResponseDimension].response
    FROM [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact]
        LEFT JOIN ir_powerbi.dbo.[Relay.dbo_ResponseDimension] ON ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
    WHERE ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
        AND [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].questionid =3 ) q3 on q3.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid, ir_powerbi.dbo.[Relay.dbo_ResponseDimension].response
    FROM [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact]
        LEFT JOIN ir_powerbi.dbo.[Relay.dbo_ResponseDimension] ON ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
    WHERE ir_powerbi.dbo.[Relay.dbo_ResponseDimension].responseid = [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].responseid
        AND [ir_powerbi].[dbo].[Relay.dbo_QuestionResponseFact].questionid =4 ) q4 on q4.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].coursegrade
    FROM [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact]
    WHERE [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].courseid = 1)
c1 on c1.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].coursegrade
    FROM [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact]
    WHERE [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].courseid = 2)
c2 on c2.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].coursegrade
    FROM [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact]
    WHERE [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].courseid = 3)
c3 on c3.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN (SELECT studentid, [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].coursegrade
    FROM [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact]
    WHERE [ir_powerbi].[dbo].[Relay.dbo_CourseGradeFact].courseid = 4) c4 on c4.studentid = [ir_powerbi].[dbo].[Relay.dbo_StudentFact].studentid

    LEFT JOIN ir_powerbi.dbo.[Relay.SchoolInformation] on [Relay.SchoolInformation].id = [ir_powerbi].[dbo].[Relay.dbo_StudentEducationHistoryFact].undergrad_unit_id or [Relay.SchoolInformation].fed_sch_cd = [Relay.dbo_StudentEducationHistoryFact].undergrad_fed_sch_cd

ORDER BY ir_powerbi.dbo.[Relay.dbo_StudentFact].studentid
