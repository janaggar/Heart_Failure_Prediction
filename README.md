# Heart Failure Prediction

**Alexandria University — Faculty of Computer and Data Science, Department of Data Science**
**Course:** Introduction to Data Science (02-24-00104), 2023–2024

## 1. Introduction
Heart failure is a common event caused by cardiovascular diseases. This project analyzes 11 clinical/demographic factors to predict the presence of heart disease, enabling early detection and intervention. The dataset was collected from patients without heart failure at baseline (2010 health check-ups), followed annually for 4 years, showing that heart failure probability increases with the number of risk factors present.

### Dataset Features
| Feature | Description |
|---|---|
| `Age` | Age of the patient (years) |
| `Sex` | M: Male, F: Female |
| `ChestPainType` | TA, ATA, NAP, ASY |
| `RestingBP` | Resting blood pressure (mm Hg) |
| `Cholesterol` | Serum cholesterol (mm/dl) |
| `FastingBS` | 1 if > 120 mg/dl, else 0 |
| `RestingECG` | Normal, ST, LVH |
| `MaxHR` | Max heart rate achieved (60–202) |
| `ExerciseAngina` | Y: Yes, N: No |
| `Oldpeak` | ST depression value |
| `ST_Slope` | Up, Flat, Down |
| `HeartDisease` | Target: 1 = disease, 0 = normal |

918 patient records, 11 predictor columns.

## 2. Methodology

### Data Preparation
- CSV loaded into `heart`, copied to `alldata` for flexibility
- Explored with `head()`, `summary()`, `str()`
- Cleaned: checked for duplicates (`duplicated()`) and nulls (`is.na()`) — none found
- Data types converted where needed

### Data Visualization
- **Pie charts** — gender distribution (193 female, 725 male) with computed percentages
- **Bar plots** (`ggplot2`) — heart disease proportion by sex, chest pain type, resting BP; stacked and dodged variants; multiple plots combined via `gridExtra`
- **Histograms** — age distribution split by heart disease presence
- **Box plots** — MaxHR and cholesterol vs. heart disease, used for outlier detection and removal via `boxplot.stats()`
- **Shiny app** — interactive `fluidPage` GUI with tabbed panels covering all 10 risk factors, plus dedicated Age and Cholesterol sub-tabs
- **Scatter plot** — cholesterol/age relationship with heart disease color-coded, fitted trend line via `geom_smooth`

### Supervised Learning — Decision Trees
- Built with `rpart()`; two variants:
  1. **Classification tree** (`method = "class"`) — target converted to logical (TRUE/FALSE) for interpretability; visualized with `rpart.plot`
  2. **Regression tree** (default method) — treats `HeartDisease` as continuous
- **Train/test split** — custom `create_train_test()` function, 80/20 split via row shuffling
- Model trained on the training set and used to predict heart disease risk for new patient data (example prediction: 91% risk)

### Unsupervised Learning — K-Means Clustering
- Non-numeric features removed to form `Cdata`
- `kmeans()` applied with 3 clusters
- Visualized with `fviz_cluster()` (point geometry, `theme_bw`)

## 3. Challenges
- Most features were categorical, complicating analysis and visualization choice
- Selecting the right plot/technique for each feature type required care
- Distinguishing supervised vs. unsupervised approaches for the decision tree step
- Building the Shiny GUI was the most difficult part — new concept, learned and implemented under time pressure

## 4. Key Findings
Factors that increase the probability of heart disease:
- Being male
- Exercise-induced angina
- Low fasting blood sugar
- Older age
- Higher resting blood pressure
- Higher cholesterol levels

## 5. Conclusion
Early detection of heart disease risk factors is crucial for effective management. These findings can help healthcare providers diagnose heart disease earlier and take preventive measures against cardiac events.

## Requirements
R packages: `rpart`, `rpart.plot`, `ggplot2`, `gridExtra`, `shiny`, `factoextra` (for `fviz_cluster`)

## Usage
1. Place the heart disease dataset (CSV) in the working directory
2. Run the R script/notebook sections in order: data loading → cleaning → visualization → decision trees → clustering → Shiny app
