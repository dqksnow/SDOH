neighborhood1 <- c(
  ## disagree = worse condition
  'How much you agree or disagree that people around here are willing to help their neighbor?',
  'How much you agree or disagree that people in your neighborhood generally get along with each other?',
  'How much you agree or disagree that people in your neighborhood can be trusted?',
  'How much you agree or disagree that people in your neighborhood share the same values?',
  'How much you agree or disagree that your neighborhood is clean?',
  'How much you agree or disagree that people in your neighborhood take good care of their houses and apartments?',
  'How much you agree or disagree that in your neighborhood people watch out for each other?',
  'How much you agree or disagree that your neighborhood is safe?'
)

neighborhood1_inv <- c(
  ## disagree = better condition, so the inverse score = 6 - score
  'How much you agree or disagree that there is a lot of graffiti in your neighborhood?',
  'How much you agree or disagree that your neighborhood is noisy?',
  'How much you agree or disagree that vandalism is common in your neighborhood?',
  'How much you agree or disagree that there are lot of abandoned buildings in your neighborhood?',
  'How much you agree or disagree that there are too many people hanging around on the streets near your home?',
  'How much you agree or disagree that there is a lot of crime in your neighborhood?',
  'How much you agree or disagree that there is too much drug use in your neighborhood?',
  'How much you agree or disagree that there is too much alcohol use in your neighborhood?',
  'How much you agree or disagree that you are always having trouble with your neighbors?'
)

neighborhood1_scores <- c("Strongly agree" = 1,
                          "Somewhat agree" = 2,
                          "Agree" = 2,
                          "Neutral (neither agree nor disagree)" = 3,
                          "Disagree" = 4,
                          "Somewhat disagree" = 4,
                          "Strongly disagree" = 5)

neighborhood2 <- c(
  ## disagree = worse condition
  'Many shops, stores, markets or other places to buy things I need are within easy walking distance of my home. Would you say that you...',
  'It is within a 10-15 minute walk to a transit stop (such as bus, train, trolley, or tram) from my home. Would you say that you...',
  'There are sidewalks on most of the streets in my neighborhood. Would you say that you...',
  'There are facilities to bicycle in or near my neighborhood, such as special lanes, separate paths or trails, or shared use paths for cycles and pedestrians. Would you say that you...',
  'My neighborhood has several free or low-cost recreation facilities, such as parks, walking trails, bike paths, recreation centers, playgrounds, public swimming pools, etc. Would you say that you...'
)

neighborhood2_inv <- c(
  ## disagree = better condition
  'The crime rate in my neighborhood makes it unsafe to go on walks at night. Would you say that you...',
  'The crime rate in my neighborhood makes it unsafe to go on walks during the day. Would you say that you...'
)

neighborhood2_scores <- c("Strongly agree" = 1,
                          "Somewhat agree" = 2,
                          "Somewhat disagree" = 3,
                          "Strongly disagree" = 4)

everyday_discrimination <- c(
  # higher score = worse condition
  'In your day-to-day life, how often are you treated with less courtesy than other people?',
  'In your day-to-day life, how often are you treated with less respect than other people?',
  'In your day-to-day life, how often do you receive poorer service than other people at restaurants or stores?',
  'In your day-to-day life, how often do people act as if they think you are not smart?',
  'In your day-to-day life, how often do people act as if they are afraid of you?',
  'In your day-to-day life, how often do people act as if they think you are dishonest?',
  "In your day-to-day life, how often do people act as if they're better than you are?",
  'In your day-to-day life, how often are you called names or insulted?',
  'In your day-to-day life, how often are you threatened or harassed?'
)

everyday_discrimination_scores <- c("Never" = 1,
                                    "Less than once a year" = 2,
                                    "A few times a year" = 3,
                                    "A few times a month" = 4,
                                    "At least once a week" = 5,
                                    "Almost everyday" = 6)


health_discrimination <- c(
  # higher score = worse condition
  "How often are you treated with less courtesy than other people when you go to a doctor's office or other health care provider?",
  "How often are you treated with less respect than other people when you go to a doctor's office or other health care provider?",
  "How often do you receive poorer service than others when you go to a doctor's office or other health care provider?",
  "How often does a doctor or nurse act as if he or she thinks you are not smart when you go to a doctor's office or other health care provider?",
  "How often does a doctor or nurse act as if he or she is afraid of you when you go to a doctor's office or other health care provider?",
  "How often does a doctor or nurse act as if he or she is better than you when you go to a doctor's office or other health care provider?",
  "How often do you feel like a doctor or nurse is not listening to what you were saying. when you go to a doctor's office or other health care provider?"
)

health_discrimination_scores <- c("Never" = 1,
                                  "Rarely" = 2,
                                  "Sometimes" = 3,
                                  "Most of the time" = 4,
                                  "Always" = 5)

food_insecurity <- c(
  "Within the past 12 months, were you worried whether your food would run out before you got money to buy more?",
  "Within the past 12 months, were you worried whether the food you had bought just didn't last and you didn't have money to get more?"
)
food_insecurity_scores <- c("Never true" = 1,
                            "Sometimes true" = 2,
                            "Often true" = 3)


################## FI

PaFHH_questions_frailty <- c(
  # Heart and Blood Conditions
  "Including yourself, who in your family has had anemia? Select all that apply.",
  "Including yourself, who in your family has had aortic aneurysm? Select all that apply.",
  "Including yourself, who in your family has had atrial fibrillation (or a-fib) or atrial flutter (or a-flutter)? Select all that apply.",
  "Including yourself, who in your family has had congestive heart failure? Select all that apply.",
  "Including yourself, who in your family has had coronary artery/coronary heart disease? Select all that apply.",
  "Including yourself, who in your family has had a heart attack? Select all that apply.",
  "Including yourself, who in your family has had heart valve disease? Select all that apply.",
  "Including yourself, who in your family has had high blood pressure (hypertension)? Select all that apply.",
  "Including yourself, who in your family has had high cholesterol? Select all that apply.",
  "Including yourself, who in your family has had peripheral vascular disease? Select all that apply.",
  "Including yourself, who in your family has had pulmonary embolism or deep vein thrombosis (DVT)? Select all that apply.",
  "Including yourself, who in your family has had sickle cell disease? Select all that apply.",
  "Including yourself, who in your family has had a stroke? Select all that apply.",
  # Digestive Conditions
  "Including yourself, who in your family has had acid reflux? Select all that apply.",
  "Including yourself, who in your family has had celiac disease? Select all that apply.",
  "Including yourself, who in your family has had colon polyps? Select all that apply.",
  "Including yourself, who in your family has had Crohn's disease? Select all that apply.",
  "Including yourself, who in your family has had diverticulitis/diverticulosis? Select all that apply.",
  "Including yourself, who in your family has had gall stones? Select all that apply.",
  "Including yourself, who in your family has had irritable bowel syndrome (IBS)? Select all that apply.",
  "Including yourself, who in your family has had a liver condition (e.g., cirrhosis)? Select all that apply.",
  "Including yourself, who in your family has had peptic (stomach) ulcers? Select all that apply.",
  "Including yourself, who in your family has had ulcerative colitis? Select all that apply.",
  # Hormone and Endocrine Conditions
  "Including yourself, who in your family has had hyperthyroidism? Select all that apply.",
  "Including yourself, who in your family has had hypothyroidism? Select all that apply.",
  "Including yourself, who in your family has had type 1 diabetes? Select all that apply.",
  "Including yourself, who in your family has had type 2 diabetes? Select all that apply.",
  "Including yourself, who in your family has had other/unknown diabetes? Select all that apply.",
  # Kidney Conditions
  "Including yourself, who in your family has had kidney stones? Select all that apply.",
  # Lung Conditions
  "Including yourself, who in your family has had asthma? Select all that apply.",
  "Including yourself, who in your family has had chronic lung disease (COPD, emphysema, or bronchitis)? Select all that apply.",
  "Including yourself, who in your family has had sleep apnea? Select all that apply.",
  # Brain and Nervous System Conditions
  "Including yourself, who in your family has had dementia (includes Alzheimer's, vascular, etc.)? Select all that apply.",
  "Including yourself, who in your family has had epilepsy or seizure? Select all that apply.",
  "Including yourself, who in your family has had Lou Gehrig's disease (amyotrophic lateral sclerosis)? Select all that apply.",
  "Including yourself, who in your family has had migraine headaches? Select all that apply.",
  "Including yourself, who in your family has had multiple sclerosis (MS)? Select all that apply.",
  "Including yourself, who in your family has had muscular dystrophy (MD)? Select all that apply.",
  "Including yourself, who in your family has had narcolepsy? Select all that apply.",
  "Including yourself, who in your family has had neuropathy? Select all that apply.",
  "Including yourself, who in your family has had Parkinson's disease? Select all that apply.",
  "Including yourself, who in your family has had restless leg syndrome? Select all that apply.",
  # Mental Health and Substance Use Conditions
  "Including yourself, who in your family has had alcohol use disorder? Select all that apply.",
  "Including yourself, who in your family has had anxiety reaction/panic disorder? Select all that apply.",
  "Including yourself, who in your family has had autism spectrum disorder? Select all that apply.",
  "Including yourself, who in your family has had bipolar disorder? Select all that apply.",
  "Including yourself, who in your family has had depression? Select all that apply.",
  "Including yourself, who in your family has had a drug use disorder? Select all that apply.",
  "Including yourself, who in your family has had schizophrenia? Select all that apply.",
  # Bone, Joint, and Muscle Conditions
  "Including yourself, who in your family has had fibromyalgia? Select all that apply.",
  "Including yourself, who in your family has had gout? Select all that apply.",
  "Including yourself, who in your family has had osteoarthritis? Select all that apply.",
  "Including yourself, who in your family has had osteoporosis? Select all that apply.",
  "Including yourself, who in your family has had pseudogout (CPPD)? Select all that apply.",
  "Including yourself, who in your family has had rheumatoid arthritis (RA)? Select all that apply.",
  "Including yourself, who in your family has had spine, muscle, or bone disorders (non-cancer)? Select all that apply.",
  "Including yourself, who in your family has had systemic lupus? Select all that apply.",
  # Hearing and Eye Conditions
  "Including yourself, who in your family has had cataracts? Select all that apply.",
  "Including yourself, who in your family has had glaucoma? Select all that apply.",
  "Including yourself, who in your family has had macular degeneration? Select all that apply.",
  "Including yourself, who in your family has had severe hearing loss or partial deafness in one or both ears? Select all that apply."
)

Basics_questions_frailty <- c(
  "Disability: Deaf",
  "Disability: Blind",
  "Disability: Errands Alone",
  "Disability: Dressing Bathing",
  "Disability: Walking Climbing",
  "Disability: Difficulty Concentrating"
)

Overall_questions_frailty <- 
  c("Overall Health: General Health",
    "Overall Health: General Quality",
    "Overall Health: General Physical Health",
    "Overall Health: General Mental Health",
    "Overall Health: Social Satisfaction",
    "Overall Health: Everyday Activities",
    "Overall Health: General Social",
    "Overall Health: Emotional Problem 7 Days"
  )