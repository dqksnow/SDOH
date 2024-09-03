## assume data has been saved in appropriate path.
library(tidyverse)
library(bigrquery)
library(ggplot2)

read_bq_export_from_workspace_bucket <- function(export_path) {
  col_types <- cols(survey = col_character(), question = col_character(), 
                    answer = col_character(), 
                    survey_version_name = col_character())
  bind_rows(
    map(system2('gsutil', args = c('ls', export_path), stdout = TRUE, 
                stderr = TRUE),
        function(csv) {
          message(str_glue('Loading {csv}.'))
          chunk <- read_csv(pipe(str_glue('gsutil cat {csv}')), 
                            col_types = col_types, show_col_types = FALSE)
          if (is.null(col_types)) {
            col_types <- spec(chunk)
          }
          chunk
        }))
}
# load data
# comparison group:

survey_39576099_path <- file.path('gs://fc-secure-31b8d2e6-4164-4d18-8997-3d51234f6b80/bq_exports/qingkai.dong@researchallofus.org/20240811/survey_39576099/survey_39576099_*.csv')

compare_survey_df <- 
  read_bq_export_from_workspace_bucket(survey_39576099_path)

dim(compare_survey_df)

head(compare_survey_df, 5)

# breast cancer group:

survey_50101718_path <- file.path('gs://fc-secure-31b8d2e6-4164-4d18-8997-3d51234f6b80/bq_exports/qingkai.dong@researchallofus.org/20240811/survey_50101718/survey_50101718_*.csv')

BCancer_survey_df <- 
  read_bq_export_from_workspace_bucket(survey_50101718_path)

dim(BCancer_survey_df)

head(BCancer_survey_df, 5)

# comparison group demographic
person_39576099_path <- file.path('gs://fc-secure-31b8d2e6-4164-4d18-8997-3d51234f6b80/bq_exports/qingkai.dong@researchallofus.org/20240811/person_39576099/person_39576099_*.csv')


compare_demographic_df <- 
  read_bq_export_from_workspace_bucket(person_39576099_path)

dim(compare_demographic_df)

head(compare_demographic_df, 5)

# breast cancer group demographic

person_50101718_path <- file.path('gs://fc-secure-31b8d2e6-4164-4d18-8997-3d51234f6b80/bq_exports/qingkai.dong@researchallofus.org/20240811/person_50101718/person_50101718_*.csv')

BCancer_demographic_df <- 
  read_bq_export_from_workspace_bucket(person_50101718_path)

dim(BCancer_demographic_df)

head(BCancer_demographic_df, 5)

# the number of patients in each group
length(unique(BCancer_survey_df$person_id))
length(unique(compare_survey_df$person_id))


## change the format of age and divide to 3 groups
## modify on the original data or create new data frame.
library(lubridate)

compare_demographic_df$date_of_birth <- 
  as.POSIXct(compare_demographic_df$date_of_birth, tz = "UTC")

BCancer_demographic_df$date_of_birth <- 
  as.POSIXct(BCancer_demographic_df$date_of_birth, tz = "UTC")

current_year <- 2021
compare_demographic_df <- compare_demographic_df %>%
  mutate(age = current_year - year(date_of_birth))
compare_demographic_df <- compare_demographic_df %>%
  select(-date_of_birth)

BCancer_demographic_df <- BCancer_demographic_df %>%
  mutate(age = current_year - year(date_of_birth))
BCancer_demographic_df <- BCancer_demographic_df %>%
  select(-date_of_birth)

head(compare_demographic_df)

## add age group and race group
compare_demographic_df <- compare_demographic_df %>%
  mutate(race_group = case_when(
    race == "White" ~ "White",
    race == "Black or African American" ~ "Black",
    race == "Asian" ~ "Asian",
    TRUE ~ "Other"
  ))
BCancer_demographic_df <- BCancer_demographic_df %>%
  mutate(race_group = case_when(
    race == "White" ~ "White",
    race == "Black or African American" ~ "Black",
    race == "Asian" ~ "Asian",
    TRUE ~ "Other"
  ))
compare_demographic_df <- compare_demographic_df %>%
  mutate(age_group = case_when(
    age < 39 ~ "<40",
    age >= 40 & age <= 65 ~ "41-65",
    age > 66 ~ ">66",
    TRUE ~ "unknown"
  ))
BCancer_demographic_df <- BCancer_demographic_df %>%
  mutate(age_group = case_when(
    age < 39 ~ "<40",
    age >= 40 & age <= 65 ~ "41-65",
    age > 66  ~ ">66",
    TRUE ~ "unknown"
  ))

# compute score for each SDOH construct
# neighborhood community (nb1)
average_score_df <- combine_and_plot(construct_name = "neighborhood community",
                                     questions = neighborhood1,
                                     scores = neighborhood1_scores,
                                     inv_questions = neighborhood1_inv,
                                     max_scores = 5)

neighborhood1_scores_cancer <- average_score_df$average_scores_cancer
neighborhood1_scores_compare <- average_score_df$average_scores_compare
SDOH_scores_demo_cancer_df <- merge(neighborhood1_scores_cancer, 
                                    BCancer_demographic_df, by = "person_id") %>%
  rename(nb1 = average_score)
SDOH_scores_demo_compare_df <- merge(neighborhood1_scores_compare,
                                     compare_demographic_df, by = "person_id") %>%
  rename(nb1 = average_score)

head(SDOH_scores_demo_cancer_df)
head(SDOH_scores_demo_compare_df)

## neighborhood accessibility(nb2)

average_score_df <- combine_and_plot(construct_name = "neighborhood accessibility",
                                     questions = neighborhood2,
                                     scores = neighborhood2_scores,
                                     inv_questions = neighborhood2_inv,
                                     max_scores = 4)

neighborhood2_scores_cancer <- average_score_df$average_scores_cancer
neighborhood2_scores_compare <- average_score_df$average_scores_compare
SDOH_scores_demo_cancer_df <- merge(neighborhood2_scores_cancer, 
                                    SDOH_scores_demo_cancer_df, by = "person_id")  %>%
  rename(nb2 = average_score)
SDOH_scores_demo_compare_df <- merge(neighborhood2_scores_compare, 
                                     SDOH_scores_demo_compare_df, by = "person_id")  %>%
  rename(nb2 = average_score)
head(SDOH_scores_demo_cancer_df)

# everyday_discrimination (dc1)

average_score_df <- combine_and_plot(construct_name = "everyday discrimination",
                                     questions = everyday_discrimination,
                                     scores = everyday_discrimination_scores,
                                     max_scores = 6)

discrimination1_scores_cancer <- average_score_df$average_scores_cancer
discrimination1_scores_compare <- average_score_df$average_scores_compare
SDOH_scores_demo_cancer_df <- merge(discrimination1_scores_cancer, 
                                    SDOH_scores_demo_cancer_df, by = "person_id")  %>%
  rename(dc1 = average_score)
SDOH_scores_demo_compare_df <- merge(discrimination1_scores_compare, 
                                     SDOH_scores_demo_compare_df, by = "person_id") %>%
  rename(dc1 = average_score)
head(SDOH_scores_demo_compare_df)

# health_discrimination (dc2)

average_score_df <- combine_and_plot(construct_name = "health discrimination",
                                     questions = health_discrimination,
                                     scores = health_discrimination_scores,
                                     max_scores = 5)

discrimination2_scores_cancer <- average_score_df$average_scores_cancer
discrimination2_scores_compare <- average_score_df$average_scores_compare
SDOH_scores_demo_cancer_df <- merge(discrimination2_scores_cancer, 
                                    SDOH_scores_demo_cancer_df, by = "person_id")  %>%
  rename(dc2 = average_score)
SDOH_scores_demo_compare_df <- merge(discrimination2_scores_compare, 
                                     SDOH_scores_demo_compare_df, by = "person_id") %>%
  rename(dc2 = average_score)
head(SDOH_scores_demo_compare_df)

## food insecurity (fd)

average_score_df <- combine_and_plot(construct_name = "food_insecurity",
                                     questions = food_insecurity,
                                     scores = food_insecurity_scores,
                                     max_scores = 3)

average_scores_cancer <- average_score_df$average_scores_cancer
average_scores_compare <- average_score_df$average_scores_compare

food_insecurity_scores_cancer <- average_score_df$average_scores_cancer
food_insecurity_scores_compare <- average_score_df$average_scores_compare
SDOH_scores_demo_cancer_df <- merge(food_insecurity_scores_cancer, 
                                    SDOH_scores_demo_cancer_df, by = "person_id")  %>%
  rename(fd = average_score)
SDOH_scores_demo_compare_df <- merge(food_insecurity_scores_compare, 
                                     SDOH_scores_demo_compare_df, by = "person_id") %>%
  rename(fd = average_score)
head(SDOH_scores_demo_compare_df)

# add group and then merge
SDOH_scores_demo_compare_df$group <- "Comparison"
SDOH_scores_demo_cancer_df$group <- "Breast_Cancer"


## compute cumulative SDOH score
SDOH_scores_demo_df <- bind_rows(SDOH_scores_demo_cancer_df, 
                                 SDOH_scores_demo_compare_df)
SDOH_scores_demo_df$Sum <- 
  rowSums(SDOH_scores_demo_df[, c("dc1", "dc2", "nb1", "nb2", "fd")])

Normalize <- function(x) {
  min_x <- min(x, na.rm = TRUE)
  max_x <- max(x, na.rm = TRUE)
  (x - min_x) / (max_x - min_x)
}

SDOH_scores_demo_df$normSum <- 
  rowSums(sapply(SDOH_scores_demo_df[, c("dc1", "dc2", "nb1", "nb2", "fd")], 
                 Normalize))


summary(SDOH_scores_demo_df)
head(SDOH_scores_demo_df)

# print summary statistics
SDOH_to_summarize <- c('nb1', 'nb2', 'dc1', 'dc2', 'fd', 'Sum', 'normSum')
summary_table <- summarize_by_group(SDOH_scores_demo_df, 'group', 
                                    SDOH_to_summarize)
print(summary_table)
summary_table <- summarize_by_group(SDOH_scores_demo_df, 'age_group', 
                                    SDOH_to_summarize)
print(summary_table)

## test for significant difference between groups
t.test(SDOH_scores_demo_df$normSum ~ SDOH_scores_demo_df$group)
wilcox.test(SDOH_scores_demo_df$normSum ~ SDOH_scores_demo_df$group)

## within certain population, test for significant difference between groups
data <- SDOH_scores_demo_df %>%
  filter(race_group == "White") # Asian Black White
t.test(nb2 ~ group, data = data)
wilcox.test(nb2 ~ group, data=data)


## density plot
ggplot(SDOH_scores_demo_df, aes(x = normSum, fill = group)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of normSumSDOH by Cancer Group", 
       x = "normSumSDOH", 
       y = "Density") +
  theme_minimal()

###################################
###################################
###################################
###################################
## next is to compute frailty index
head(BCancer_survey_df)
dim(BCancer_survey_df)

# some answer text contains the question text, so trim the answer text.
BCancer_survey_df <- BCancer_survey_df %>%
  mutate(answer = case_when(
    survey == "Personal and Family Health History" ~ 
      str_trim(str_extract(answer, "[^\\s-]+$")),
    survey == "The Basics" ~ str_trim(str_extract(answer, "[^:]+$")),
    survey == "Overall Health" ~ str_trim(str_extract(answer, "[^:]+$")),
    TRUE ~ answer  # Keep the original answer for other surveys
    )
  )

compare_survey_df <- compare_survey_df %>%
  mutate(answer = case_when(
    survey == "Personal and Family Health History" ~ 
      str_trim(str_extract(answer, "[^\\s-]+$")),
    survey == "The Basics" ~ str_trim(str_extract(answer, "[^:]+$")),
    survey == "Overall Health" ~ str_trim(str_extract(answer, "[^:]+$")),
    TRUE ~ answer  # Keep the original answer for other survey
    )
    )

head(BCancer_survey_df)


# how many unique questions in  "The Basics" ?
unique_basics_questions <- BCancer_survey_df %>%
  filter(survey == "The Basics") %>%
  distinct(question)
print(unique_basics_questions, n = nrow(possible_answers))

# We notice that many people have no answers to Basics_questions_frailty.
# So we check their complete date.
monthly_survey_count <- BCancer_survey_df %>%
  filter(survey == 'The Basics') %>%
  mutate(survey_month = floor_date(ymd_hms(survey_datetime), "month")) %>%
  group_by(person_id, survey_month) %>%
  summarise(answers_count = n(), .groups = 'drop') %>%
  group_by(survey_month, answers_count) %>%
  summarise(completions = n(), .groups = 'drop')

print(monthly_survey_count, n = Inf)


combined_questions_frailty <- c(
  PaFHH_questions_frailty,
  Basics_questions_frailty,
  Overall_questions_frailty
) # 75 in total

yes_answers <- c("Self", "Yes", "Fair", "Poor", "Not At All", "Always") 
# these answers = 1(bad condition), others = 0

# only include participants who answered all 75 questions.
frailty_index_cancer <- compute_frailty_index(BCancer_survey_df, 
                                              combined_questions_frailty, yes_answers)

frailty_index_compare <- compute_frailty_index(compare_survey_df, 
                                               combined_questions_frailty, yes_answers)

sum(frailty_index_cancer$answered_questions == 75)
sum(frailty_index_compare$answered_questions == 75)

# merge FI with demography data
frailty_index_demo_cancer_df <- merge(frailty_index_cancer, 
                                      BCancer_demographic_df, by = "person_id")  
frailty_index_demo_compare_df <- merge(frailty_index_compare, 
                                       compare_demographic_df, by = "person_id")
frailty_index_demo_compare_df$group <- "Comparison"
frailty_index_demo_cancer_df$group <- "Breast_Cancer"
frailty_index_demo_df <- bind_rows(frailty_index_demo_cancer_df, 
                                   frailty_index_demo_compare_df)
summary(frailty_index_demo_df)


## summary statistics for FI
FI_to_summarize <- c('FI')
summary_table <- summarize_by_group(frailty_index_demo_df, 'group', FI_to_summarize)
print(summary_table)


# do test
data <- frailty_index_demo_df %>%
  filter(race_group == "Asian") #  <40  41-65  >66
t.test(FI ~ group, data = data)
wilcox.test(FI ~ group, data = data)

data <- frailty_index_demo_df %>%
  filter(race_group == "Black") #  <40  41-65  >66
t.test(FI ~ group, data = data)
wilcox.test(FI ~ group, data = data)

data <- frailty_index_demo_df %>%
  filter(race_group == "White") #  <40  41-65  >66
t.test(FI ~ group, data = data)
wilcox.test(FI ~ group, data = data)

print("FI, Cancer, grouped by age")
summarize_by_group(frailty_index_demo_cancer_df, 'age_group', 'FI')
print("FI, Compare, grouped by age")
summarize_by_group(frailty_index_demo_compare_df, 'age_group', 'FI')
print("FI, Cancer, grouped by race")
summarize_by_group(frailty_index_demo_cancer_df, 'race_group', 'FI')
print("FI, Compare, grouped by race")
summarize_by_group(frailty_index_demo_compare_df, 'race_group', 'FI')


combined_scores <- frailty_index_demo_df %>%
  mutate(score_range = cut(FI, breaks = seq(0, 1, by = 0.1), include.lowest = TRUE))

# boxplot
ggplot(SDOH_FI_df, aes(x = group, y = FI, fill = group)) +
  geom_boxplot() +
  labs(title = "Distribution of FI by Cancer Group", 
       x = "Group", 
       y = "Frailty Index (FI)") +
  theme_minimal()

# density plot
ggplot(SDOH_FI_df, aes(x = FI, fill = group)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of FI by Cancer Group", 
       x = "Frailty Index (FI)", 
       y = "Density") +
  theme_minimal()

## scatter plot

plot_fi_vs_variable(SDOH_FI_df, "normSumSDOH")
summary(lm(FI ~ normSumSDOH, data = SDOH_FI_df))

## correlation

correlation_cancer <- calculate_correlations(SDOH_FI_df, "Breast_Cancer")
correlation_comparison <- calculate_correlations(SDOH_FI_df, "Comparison")
correlation_all <- calculate_correlations(SDOH_FI_df)
print("Correlations and p-values for Breast Cancer Group:")
print(correlation_cancer)

print("Correlations and p-values for Comparison Group:")
print(correlation_comparison)

print("Correlations and p-values for All Groups Combined:")
print(correlation_all)
