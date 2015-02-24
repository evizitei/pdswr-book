# initially tried csv loading, no good for space delimited data
germanData <- read.table("~/Code/data-analysis/practical-data-science-with-R/data/german.data",
  sep='', stringsAsFactors=F,header=F)

# confirm the data by peeking at the first 3 rows
print(germanData[1:3,])

# update column names for the frame
colnames(germanData) <- c(
  "Status.of.checking", "Duration.in.months", "Credit.history",
  "Purpose","Credit.amount","Savings","Present.employment.since",
  "Installment.rate.in.percentage.of.disposable.income",
  "Personal.status.and.sex","Other.debtors","Present.residence.since",
  "Property", "Age", "Other.installment.plans", "Housing",
  "Existing.bank.credits", "Job", "Dependants", "Telephone", 
  "Foreign.worker", "Good.Loan"
)

print(germanData[1:3,])

# transform the numeric "good.loan" value into an enumerator value we can understand
germanData$Good.Loan <- as.factor(ifelse(germanData$Good.Loan == 1,"GoodLoan","BadLoan"))

# mapping for loan codes, see process.log for how to generate
loanCodeMapping <- list(
  'A11'='... < 0 DM',
  'A12'='0 <= ... < 200 DM',
  'A13'='... >= 200 DM / salary assignments for at least 1 year',
  'A14'='no checking account',
  'A30'='no credits taken/ all credits paid back duly',
  'A31'='all credits at this bank paid back duly',
  'A32'='existing credits paid back duly till now',
  'A33'='delay in paying off in the past',
  'A34'='critical account/ other credits existing (not at this bank)',
  'A40'='car (new)',
  'A41'='car (used)',
  'A42'='furniture/equipment',
  'A43'='radio/television',
  'A44'='domestic appliances',
  'A45'='repairs',
  'A46'='education',
  'A47'='(vacation - does not exist?)',
  'A48'='retraining',
  'A49'='business',
  'A410'='others',
  'A61'='... < 100 DM',
  'A62'='100 <= ... < 500 DM',
  'A63'='500 <= ... < 1000 DM',
  'A64'='.. >= 1000 DM',
  'A65'='unknown/ no savings account',
  'A71'='unemployed',
  'A72'='... < 1 year',
  'A73'='1 <= ... < 4 years',
  'A74'='4 <= ... < 7 years',
  'A75'='.. >= 7 years',
  'A91'='divorced/separated',
  'A92'='divorced/separated/married',
  'A93'='single',
  'A94'='married/widowed',
  'A95'='single',
  'A101'='none',
  'A102'='co-applicant',
  'A103'='guarantor',
  'A121'='real estate',
  'A122'='building society savings agreement/ life insurance',
  'A123'='car or other, not in attribute 6',
  'A124'='unknown / no property',
  'A141'='bank',
  'A142'='stores',
  'A143'='none',
  'A151'='rent',
  'A152'='own',
  'A153'='for free',
  'A171'='unemployed/ unskilled - non-resident',
  'A172'='unskilled - resident',
  'A173'='skilled employee / official',
  'A174'='management/ self-employed/highly qualified employee/ officer ',
  'A191'='none',
  'A192'='yes, registered under the customers name',
  'A201'='yes',
  'A202'='no'
)

# transform codes in the data via the above mapping
for(i in 1:(dim(germanData))[2]) {                                              # for each column in the frame
  if(class(germanData[,i]) == 'character') {                                    # if the type of this column is a string
    germanData[,i] <- as.factor(as.character(loanCodeMapping[germanData[,i]]))  # map the column data through the loan codes above
  }
}

# examine the break down of each purpose type against good/bad loans
table(germanData$Purpose, germanData$Good.Loan)

# look at Job vs good/bad loans
table(germanData$Job, germanData$Good.Loan)