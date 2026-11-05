---
output:
  pdf_document: default
  html_document: default
---
# Assignment-3

## Project Overview
This project is a collaborative analysis of text messaging data, completed using a GitHub branch and pull request workflow. 
We describe the number of text messages sent by two groups at two points in time using stratified visualizations and summary statistics.

## Data
- **File:** 'TextMessages.csv'
- **Observations:** 50 participants, 25 in each of the two groups
- **Variables:**
`Participant`: participant ID number
`Group`: group assignment (1 or 2), converted to a factor
`Baseline`: number of text messages at baseline 
`Six_month`: number of text messages at six months 

The data are provided in wide format and were reshaped to long format (`TextMSG_long`) so that `Time` (Baseline, Six_months) is a single variable for plotting and summarizing.

## Repository Contents
- `TextMessages.csv`: the dataset
- `Assignment3.R`: R file containing all code and comments
- `Assignment3.Rmd`: R Markdown file containing all code and interpretation 
- `Assignment3.pdf`: the knitted final report
- `README.md`: this file

## How to Run the Analysis
1. Clone the repository in RStudio: **File > New Project > Version Control > Git**, then paste the repository URL.
2. Install the required packages (one time only):
`install.packages(c("tidyverse", "Hmisc", "knitr"))`
3. Open `Assignment3.Rmd` and click **Knit** to produce the PDF.

**Note:** No working directory changes are needed because the RStudio project automatically sets it.

## Analysis Summary
- **Data prepartion:** examined the data structure, converted `Group` and `Time` to factors, and reshaped the data to long format
- **Visualization 1:** faceted boxplot of text messages by Group and Time, with individual data points shown.
- **Visualization 2:** faceted bar chart of mean text messages by Group and Time, with 95% confidence intervals
- **Summary Statistics:** n, mean, SD, median, Q1, and Q3 of text messages by Group and Time

**Key Findings:** Both groups has similar text messages counts at baseline (means of about 65). 
At six months, counts for both groups declined, but Group 1 (mean 53.0) had a larger drop than Group 2 (mean 61.8).
Group 1's six-month data include low outliers that pull its mean below its median. 
All results are descriptive; we did not perform formal statistical testing.

## Contributions

### Lana
Repository setup, data exploration and preparation, long-format shaping, Visualization 1, conclusion

### Chloe
Visualization 2, summary statistics, README file, final report assembly, submission

## Workflow / Change Log
- `readme-structure`: added README section headings
- `Lana-branch`: data setup, long-format reshaping, and boxplot
- `barchart-visualization`: faceted bar chart with 95% CIs
- `summary-statistics`: summary statistics by Group and Time
- `Lana-globalbranch`: group edits made during meeting, Lana edits post-meeting, including added conclusion
- `readme-edits`: completed sections in README file
- `create-final-report`: created final report in .Rmd file, made final edits 
- `readme-edits`: finalized README file
