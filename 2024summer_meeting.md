

# 08/25/2024

+ Working log
  - References Summary:
    - [hagan2023cumulative](https://github.com/zefangm/sdhaa/blob/main/references/hagan2023cumulative.pdf)
      analyized the association between SDOH and Health and Activity Limitation
      Index(HALex).
      - For SDOH, they choose questions from six domains. All
      answers are tansfered to 0-1 scores. The summation of scores is the
      Cumulative SDoH score. They divided the study group into quartiles based
      on score.
      - HALex scores range from 0.10 (the worst combined
      health state) to 1.00 (the most favorable). This paper evaluated HALex as
      both a continuous outcome (HALex score) and a binary outcome, poor HALex
      (yes/ no). Poor HALex was defined as a HALex score less than the 20th
      percentile (0.79).
      - They showed that Cumulative social disadvantage was
      associated with poorer HALex performance in an incremental fashion. The
      also analyized the assiciation grouped by age and race.
      - For missing data, they first excluded them and reanalyzed by imputation.
    - [acquah2023social](https://github.com/zefangm/sdhaa/blob/main/references/acquah2023social.pdf)
      analyized the association between SDoH and cardiovascular risk
      factors. They computed a weighted aggregate SDOH score, identified from 14
      components across 5 domains. Among the 5 domains, some included
      significantly more items than others, so they weighted the domains to
      ensure that they had equal weights, irrespective of the number of items
      included in each. Weighting was done such that each domain had a total
      possible score of 0.2. The scores of the 5 domains were then summed to
      define the final SDOH aggregate index, which ranged from 0 to 1. They also
      divided study group into quartiles.
  - For SDOH:
    - normalize each score ((score-min)/range) and sum up.
    - draw plots.
  - For FI:
    - Compute FI for 392 in cancer group who compeleted all 75 questions. 5254 in comparison group.
    - Compute correlation between FI and normSumSDOH   
    - The coefficient in the linear model is significant but the correlation is
    not strong. We can try compute the correlation between quartiles of FI and
    SDOH. Also try quartile of SDOH and FI. Refer to two references.
  - Investigate the reason of missing answers to 6 questions in 'The Basics':
    - The time of participants response to 'The Basics' uniformly spread
      over the period August 2016 to June 2022.
    - No one answer these 6 questions until Nov 2018. From this point on, most
      participants answered these 6 questions.
      
# 08/19/2024

+ Working log
  - SDOH score:
    - do tests to compare five constructs scores between cancer and compare group.
    - sum 5 scores up to build a overall score and do test.
    - normalzied and sum 5 scores up to build a normalized overall score and do test.
    - for each constructs score and overall score, do test by age and race.
  - Frailty index
    - We use 75 questions from three surveys(Modules) to construct the FI (6 from Basic,
      8 from OverallHealth and 61 from Personal and Family, 75 in total)
    - In OveallHealth module, there are 24 distinct questions. We choose 8 of
      24. All 3558 patients in cancer group answered all 8 questions.
    - In Basic module, there are 23 distinct questions. We choose 6 of 23 which
      related to “Frailty”. All 3558 patients in cancer group answered at least
      1 question in these 23 questions. 1684 answered all of the 6
      questions we choose and other 1874 answered 0 of these 6.
    - Personal and Family Health History (PaF) is a follow-up survey after completion
      of the Basics, Overall Health, and Lifestyle surveys. In Personal and
      Family module, we choose 61 questions. 1920 answered
      all of the 61 questions we selected. 3196 answered at least 1 question in
      these 61 questions.
    - The intersection of 1684 and 1920 is 392 patients. For comparison group,
      the intersection is 5254.
    - Why some patients didn't answer these questions?
      - Skip. But these questions have option 'skip'.
      - Follow-up questions. The 6 questions in 'Basic' are not follow-up but 61
        questions in 'PaF' are. But it can't explain why more than half answered all 61.
      - The survey data might be combined from different sources.	
    - Solutions:
      - As suggested in (Rockwood and Mitnitski, 2007), when some sufﬁciently
      large number (roughly, about 40) variables are considered, the variables
      can be selected at random, and still yield comparable results of the risks
      of adverse outcomes. So I choose patients with answered questions >=40 and
      compute FI=(# of yes)/(# of answered questions). The number left in cancer
      group is 2018 and in comparison group is 25304. Do tests for FI.
      - Treat missing as 0. Then FI=(# of yes) / 75.

 + meeting discussion points
   - For SDOH score:
     - When combine these 5 scores:
       - Check the [references](https://github.com/zefangm/sdhaa/blob/main/references/acquah2023social.pdf)
       - Do normalization correctly, (score-min)/range.
       - Show histograms. X axis should be scores, not intervals.
     - The variance of comparison group tends to be larger than cancer group.
   - For Frailty Index:
     - For Basics module
       - To find out if there are really two versions of survey, check the
         survey completion date for participants.
       - Are there any alternates to these 6 questions? Maybe there are some
         questions related to disability in PaF survey.
       - In the case of recovering missing questions, we just need to impute the
         sum of these 6 questions, not individual.
     - Compute FI on 392 and 5254 participants who answered all 75 questions.
     - Compute the correlation between FI and SDOH, compare the strength of
       association between cancer and comaprison.
	 
# 08/12/2024

+ Working log
  - Removed sex == male or unknown patients from breast cancer group. 3704 to 3558 
  - SDOH Score Tables:
    - compare breast cancer group and comparison group.
    - compare age differences within breast cancer group and comparison group.
    - compare race differences within breast cancer group and comparison group.
  - Frailty Index:
    - Basically patients don't answer all of these 75 frailty index indicator
      questions. Quantiles of # of answered questions: 8.00, 20.25, 43.44, 69.00, 74.00.
    - FI=(# of yes)/(# of answered questions).
    - FI Score Tables:
      - compare breast cancer group and comparison group.
      - compare age differences within breast cancer group and comparison group.
      - compare race differences within breast cancer group and comparison group.

 + meeting discussion points
   - For SDOH score:
     - Not only show tables, do some tests to compare SDOH scores from different group:
       - Cancer vs Compare
       - age
       - race
     - Consider how to combine these 5 SDOH scores to 1. Try to sum them up
       first and consider adding weights later. Read papers provided by
       Prof. Bellizzi for reference.
   - For Frailty Index:
     - Score 'fair' as 1 as well as 'poor'.
     - Many patients answered far fewer than 75 questions.
       - Are any patients who didn't answer a particular survey included in the
         cohort?
       - Are patients who answer a particular survey really answered all of the
         questions in the survey? If not, how many questions they answered in
         the survey?
       - Are all of these 75 questions applicable to each patients?
       - Print out how many patients completed each survey. Print out the number
         of questions that patients answered. And the number of patients
         answered some specific questions.

# 08/04/2024

+ Working log
  - For five interested SDOH constructs, more bar plots are provided.
    - black group tends to have higher score than white and asian group.
    - younger group tends to have higher score than older.
    - female group tends to have higher score than male but male is relatively
      rare.
  - Frailty index (6+8+61=75 in total):
    - "Disability questions"(The Basics Module):
      - 6 questions
      - all "yes or no" questions which ask about health condition.
    - "health and daily activities"(The overall health module)
      - 10 quesions. We use 8 of them.
      - 8 questions have 5 options "Excellent", "Very good", "Good", "Fair" and
        "Poor". Or "Never", "Rarely", "Sometimes", "Often" and "Always". We set
        the worst option as "1" and others  as "0". In such way they are
        converted to binary variable.
      - two questions are about pain rate and fatigue rate. We remove them.
    - "Comorbidity"(Personal and Family History Module).
      - We only need "are you this condition" indicators with more than 100,000
        reponses. There are 61 questions meet requirements.
      - Heart and Blood Conditions
      	- 13 questions can be used, each has more than 100,000
                responses. e.g. "Including yourself, who in your family has had
                high cholesterol? Select all that apply". Treat "self" as "1"
                and other as "0".
      - Digestive Conditions
      	- 10 questions have more than 100,000 response. e.g. "Including
                yourself, who in your family has had acid reflux? Select all
                that apply."
      - Hormone and Endocrine Conditions
      	- 5 questions
      - Kidney Conditions
      	- 1 questions.
      - Lung Conditions
      	- 3 questions.
      - Brain and nervous system conditions
      	- 10 questions
      - Mental Health and Substance Use Conditions
        - 7 questions
      - Bone, joint, and muscle conditions
        - 8 questions
      - Hearing and Eye Conditions
        - 4 questions

 + meeting discussion points
   - Remove male patients from breast cancer group. 
   - Compute frailty index for breast cancer group and comparison group based
      on these 75 indicatiors. Show summary.
   - Compare frailty index for breast cancer group and comparison group.
   - Show summary about SDOH for breast cancer group and comparison group.
   - Compare frailty index by race and age within each group.
   - There are some questions about breast cancer in Personal and Family Health
      History module. Draw plots by race and age.

# 07/29/2024

+ meeting discussion points
  - For SDOH score, the most interested constructs are neighborhood
    community(nb1), neighborhood accessibility(nb2), everyday
    discrimination(dc1), healthcare discrimination(dc2) and food
    insecurity(fd). Provide more details about these constructs (group by race,
    group by age, number of missing).
  - For frailty index:
    - carefully choose indicators in "Comorbidity"(Personal and Family History
      Module). We only need indicators like "are you in this condition".
    - convert multioption answer to binary answer. For example, assign
      "Excellent", "Very Good" and "Good" to "Yes" and "Fair", "Poor" to "No".

# 07/27/2024

+ Working log
  - 9 Constructs of SDOH (81 questions in total):
    - neighborhood 1:
      - 17 questions
      - 4 or 5 options. Higher score = worse condition. "Strongly agree" =
        1,"Agree" = 2, "Neutral (neither agree nor disagree)" = 3, "Disagree" =
        4, "Strongly disagree" = 5.
      - Some doesn't have option "Neutral".
      - Some questions have 1 missing option "Skip".
    - neighborhood 2 (combined with neighborhood 1 as neighborhood):
      - 8 questions
      - share the same 4 options. "Strongly agree" = 1, "Somewhat agree" = 2,
        "Somewhat disagree" = 4, "Strongly disagree" = 5.
      - 2 missing option "Don't know" and "Skip"
    - supportive:
      - 8 questions
      - share the same 5 options: "All of the time" = 1, "Most of the time" = 2,
        "Some of the time" = 3, "A little of the time" = 4, "None of the time" =
        5.
      - 1 missing option "Skip"
    - loneliness:
      - 8 questions
      - share the same 4 options. "Never" = 1, "Rarely" = 2, "Sometimes" = 3,
        "Often" = 4
      - 1 missing option "Skip"
    - everyday discrimination:
      - 10 questions
      - 9 of them share the same options: "Never" = 1,"Less than once a year" =
        2, "A few times a year" = 3, "A few times a month" = 4, "At least once a
        week" = 5, "Almost everyday" = 6
      - 1 missing option "Skip".
      - The other one is "the reasons for discrimination"
    - healthcare discrimination:
      - 7 questions
      - share the same 5 options: "Never" = 1, "Rarely" = 2,"Sometimes" = 3,
        "Most of the time" = 4, "Always" = 5
      - 1 missing option "Skip"
    - (*) food and house: 
      - 4 questions
      - 2 share the same options, 1 has multiple choices, 1 is count number.
    - stress:
      - 10 questions
      - share the same 5 options: "Never" = 1,"Almost Never" = 2,"Sometimes" =
        3,"Fairly Often" = 4, "Very Often" = 5
      - 1 missing option "Skip"
    - religion:
      - 7 questions
      - 6 share the same options, 1 has different options. 
      - 2 missing option "I do not believe in God" and "Skip"
      - scale from 1 to 6.
    - (*) language:
      - 2 questions
      - 1 is binary
  - Frailty index:
    - If there are 50 indicators in total, each indicator corresponds to a score
      between 0 and 1. The frailty index will be the sum of the patient's scores
      divided by 50.
    - Use indicators in "Disability questions"(The Basics Module), "health and
      daily activities"(The overall health module) and "Comorbidity"(Personal
      and Family History Module).
    - Too many indicators in "Comorbidity".



# 07/23/2024

+ Working log
  - Take away of the proposal:
    - Treatment for cancer accelerates aging. Healthy behaviors (Modifiable
      factors, such as physical activity) accelerates aging. SDOH in general
      populations also accelerates aging. We are trying to investigate the
      associations between SDOH factors (individual and/or combined) and breast
      cancer treatment. We also try to identify modifiable factors that could
      mitigate these effects.
    - One way to access accelerating age is frailty indices.
    - About the all of us dataset:
      - SDOH survey data can be used.
      - Fitbit data can be used to measure physical activity.
      - General health survey data can be used to measure frailty.
    - Currently the tasks are to:
      - Build the cohort for cancer group and comparison group.
      - Measure frailty for cancer group and comparison group.
      - Descriptive analysis for both groups.

  - How often does all of us update their data? Data are updated
    periodically. On April 20, 2023, All of Us released new data in the
    Researcher Workbench (All of Us dataset v7).

  - After rebuilding the cohort, I regenerate the flowplot. The number of
    patients are almost the same.

+ meeting discussion points
  - Don't need to exclude Basal cell carcinoma of skin.
  
  - AllofUs survey data website [link](https://www.researchallofus.org/data-tools/survey-explorer/)
  - AllofUs survey data code books [link](https://docs.google.com/spreadsheets/d/1Ey8MScRYZ9QyS4izVYScISLMb62QEhSM-ErbG27dNtw/edit?pli=1&gid=325527898#gid=325527898)
  - Introduction paper for SDOH data in the allofus program: [link](https://www.nature.com/articles/s41598-024-57410-6)
  - Frailty index computation reference: [put link here]
  - Adjustment for years of diagnosis.


# 07/15/2024

+ rebuild the cohort to see if new breast cancer patients are included.

+ read the proposal





