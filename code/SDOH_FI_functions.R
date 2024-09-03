## define some functions for score calculation
###################################################
combine_and_plot <- function(construct_name, questions, 
                             inv_questions = rep(NA, 1), scores, max_scores) {
  if(is.na(inv_questions[1])) {
    results_cancer <- compute_average_scores(BCancer_survey_df, questions, scores)
    results_compare <- compute_average_scores(compare_survey_df, questions, scores)
  } else {
    results_cancer <- compute_scores_with_inversion(BCancer_survey_df, questions, scores, 
                                                    inv_questions, max_scores+1)
    results_compare <- compute_scores_with_inversion(compare_survey_df, questions, scores,
                                                     inv_questions, max_scores+1)
  }
  
  average_scores_cancer <- results_cancer$average_scores
  average_scores_compare <- results_compare$average_scores
  
  return(list(average_scores_cancer = average_scores_cancer,
              average_scores_compare = average_scores_compare))
}
###################################################
compute_average_scores <- function(df, questions_of_interest, answer_scores) {
  recoded_data <- df %>%
    filter(question %in% questions_of_interest) %>%
    select(person_id, question_concept_id, question, answer) %>%
    mutate(score = recode(answer, !!!answer_scores, .default = NA_real_))
  
  # Count unmatched (NA) observations in the score column
  unmatched_count <- sum(is.na(recoded_data$score))
  
  # Calculate average scores for matched observations
  average_scores <- recoded_data %>%
    group_by(person_id) %>%
    summarize(average_score = mean(score, na.rm = TRUE))
  
  return(list(average_scores = average_scores, unmatched_count = unmatched_count))
}
###################################################
# Function to compute scores considering inversion score rule
compute_scores_with_inversion <- function(df, questions, scores, inverted, score_full = 6) {
  recoded_data <- df %>%
    filter(question %in% questions) %>%
    select(person_id, question_concept_id, question, answer) %>%
    mutate(score = recode(answer, !!!scores, .default = NA_real_)) %>%
    mutate(score = ifelse(question %in% inverted, score_full - score, score))
  
  average_scores <- recoded_data %>%
    group_by(person_id) %>%
    summarize(average_score = mean(score, na.rm = TRUE))
  
  return(list(average_scores = average_scores))
}

###################################################

Normalize <- function(x) {
  min_x <- min(x, na.rm = TRUE)
  max_x <- max(x, na.rm = TRUE)
  (x - min_x) / (max_x - min_x)
}

###################################################
summarize_by_group <- function(df, group_var, columns) {
  summary_table <- df %>%
    group_by(.data[[group_var]]) %>%
    summarise(across(all_of(columns), 
                     list(
                       min = ~ min(., na.rm = TRUE), 
                       Q1 = ~ quantile(., 0.25, na.rm = TRUE), 
                       mean = ~ mean(., na.rm = TRUE), 
                       median = ~ median(., na.rm = TRUE), 
                       Q3 = ~ quantile(., 0.75, na.rm = TRUE), 
                       max = ~ max(., na.rm = TRUE), 
                       std_error = ~ sd(., na.rm = TRUE),
                       n_na = ~ sum(is.na(.)),
                       total = ~ length(.)), 
                     .names = "{col}_{fn}")) %>%
    pivot_longer(-.data[[group_var]], 
                 names_to = c("SDOH", "statistic"), 
                 names_sep = "_", 
                 values_to = "value") %>%
    pivot_wider(names_from = "statistic", values_from = "value") %>%
    relocate(.data[[group_var]], .after = SDOH) %>%
    arrange(SDOH, .data[[group_var]])
  
  return(summary_table)
}



###################################################
# Function to create the scatter plots
plot_fi_vs_variable <- function(df, variable_name) {
  p_cancer <- ggplot(df %>% filter(group == "Breast_Cancer"), aes_string(x = variable_name, y = "FI")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(Breast Cancer Group)"))
  
  p_comparison <- ggplot(df %>% filter(group == "Comparison"), aes_string(x = variable_name, y = "FI")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(Comparison Group)"))
  
  p_all <- ggplot(df, aes_string(x = variable_name, y = "FI", color = "group")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(All Groups)"))
  
  # Print the plots
  print(p_cancer)
  print(p_comparison)
  print(p_all)
}

###################################################
compute_frailty_index <- function(df, questions_list, yes_answers) {
  
  # Step 1: Filter for relevant questions and count the number
  yes_answers_counts <- df %>%
    filter(question %in% questions_list) %>%
    filter(answer %in% yes_answers) %>%
    group_by(person_id) %>%
    summarise(yes_answers_count = n())
  
  # Step 2: Count the number of questions each person answered
  answered_counts <- df %>%
    filter(question %in% questions_list) %>%
    group_by(person_id) %>%
    summarise(answered_questions = n_distinct(question))
  
  # Step 3: Filter to keep only people with exactly 75 answered questions
  answered_counts <- answered_counts %>%
    filter(answered_questions == 75)
  
  # Step 4: Calculate the frailty index for people with 75 answered questions
  frailty_index_df <- answered_counts %>%
    left_join(yes_answers_counts, by = "person_id") %>%
    mutate(yes_answers_count = replace_na(yes_answers_count, 0),  
    # Handle NA values, not necessary because once filter answered_questions == 75, there is no na.
           FI = yes_answers_count / 75)  
  return(frailty_index_df)
}

###################################################
# Function to create the scatter plots
plot_fi_vs_variable <- function(df, variable_name) {
  p_cancer <- ggplot(df %>% filter(group == "Breast_Cancer"), aes_string(x = variable_name, y = "FI")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(Breast Cancer Group)"))
  
  p_comparison <- ggplot(df %>% filter(group == "Comparison"), aes_string(x = variable_name, y = "FI")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(Comparison Group)"))
  
  p_all <- ggplot(df, aes_string(x = variable_name, y = "FI", color = "group")) +
    geom_point() +
    geom_smooth(method = "lm") +
    ggtitle(paste("FI vs", variable_name, "(All Groups)"))
  
  # Print the plots
  print(p_cancer)
  print(p_comparison)
  print(p_all)
  ggsave("FI_SDOH_cancer.pdf", plot = p_cancer, width = 8, height = 6)
  ggsave("FI_SDOH_comparison.pdf", plot = p_comparison, width = 8, height = 6)  
  ggsave("FI_SDOH_combine.pdf", plot = p_all, width = 8, height = 6)
}

###################################################
calculate_correlations <- function(df, group_name = NULL) {
  if (!is.null(group_name)) {
    df <- df %>% filter(group == group_name)
  }
  
  variables_to_correlate <- c("SumSDOH", "normSumSDOH", "fd", "dc2", "dc1", "nb2", "nb1")
  
  correlations <- numeric(length(variables_to_correlate))
  p_values <- numeric(length(variables_to_correlate))
  
  for (i in seq_along(variables_to_correlate)) {
    var <- variables_to_correlate[i]
    test <- cor.test(df$FI, df[[var]], use = "complete.obs")
    correlations[i] <- test$estimate
    p_values[i] <- formatC(test$p.value, format = "f", digits = 4)
  }
  
  correlation_table <- data.frame(
    Variable = variables_to_correlate,
    Corr_with_FI = correlations,
    p_value = p_values
  )
  
  return(correlation_table)
}