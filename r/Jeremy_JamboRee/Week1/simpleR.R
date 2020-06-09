# Demonstration of some simple tasks with R

# First of all, text with a hash (#) symbol at its beginning is a comment. Comments are just for making our code
# more readable and better documented. They aren't interpreted by R.

## Do some math
1+3 # with your cursor on this line, press ctrl+enter
# Pressing Ctrl+enter runns the current line or the current selection in the "Console" window below
# Prove it to yourself by typing "1+3", without the qotes, into the Console window below, then hit "enter"
# Hopefully you get 4 as your result either way

# You can create "variables" to do the same task ----
a = 1 # create a variable, a, representing the number 1
a

b = 3

a+b
a*b
c = 5
c*(a+b)
c**b # double-star is exponent: "c to the power of b" in this case

?log # running a line like this, with a question mark prior to a function's name, brings up the help documentation for that function in the bottom-right window.
log(c)

# Vectorize your math ----
a = c(1,3,5,7) # c() is used to combine objects into a data structure called a "vector"
1:4 # can also make a vector of integers like so. In this case 1 through 4.

# What happens when you run each of the following lines?
a
a+b

b = c(1,2,1,2)
a+b

# Slicing (getting elements of) vectors by their index (position in the vector)
a
a[2] # square brackets after a variable for slicing. In this case, we're grabbing the 2nd element of a
a[2:3] # elements 2 through 3
a[c(1,3)] # get elements 1 and 3
d = c(1,3)
a[d] # can supply the indices we want to slice with a variable.

# Make a 2-dimensional matrix ----
matrix(data=0, nrow=3, ncol=2) # run this line and see what you get
matrix(data=c(1,2,3,4,5,6), nrow=3, ncol=2) # Now this one. Note the order in which the matrix gets filled with data.
?matrix 
matrix(data=c(1,2,3,4,5,6), nrow=3, ncol=2, byrow=TRUE)
mat = matrix(data=c(1,2,3,4,5,6), nrow=3, ncol=2, byrow=TRUE)
mat

# Slicing a 2D matrix
mat[1,] # Note the comma. It separates the dimensions for slicing. Here, we've grabbed the first row, and all columns.
mat[1:2,] # First two rows
mat[,1] # First column

mat[c(1,3),2] # What does this do?

# Make a dataframe ----
?data.frame
data.frame("Var1"=c(1,2,3), "Var2"=c(4,5,6))
var1 = c(1,2,3)
var1
var2 = c(4,5,6)
data.frame("Var1"=var1, "Var2"=var2)

var3 = c('a','b','c')
df = data.frame("Var1"=var1, "Var2"=var2, "Var3"=var3)
df
# How many rows in df?
nrow(df)

# Slicing dataframes can be done in the same way as matrices, i.e., with square brackets
# Additionally, you can use '$' notation or the names of columns in the square brackets
df
df[,2]
df[,"Var2"]
df$Var2
# you can also create new columns with '$' notation

df$Var4 = 1:nrow(df)

# Let's do something more interesting with a dataframe
?rnorm
a = rnorm(n=500, mean=0, sd=1) # randomly sample 500 times from a normal distribution with mean 0 and sd 1
a
?rep
b = c(rep(x='a',times=100),rep('b',100),rep('c',100),rep('d',100),rep('e',100)) # build a vector of letters. The 'rep' function repeats a value n times
# Note that in the above line, I first used rep by naming its arguments, x and times. You can also omit the argument names as long as they are in the correct order.
b
df = data.frame(numbers=a, letters=b) # dataframe with columns called "numbers" and "letters"
df
head(df) # get first few rows of df

##### POP QUIZ!!!!! #####
# Create a new column in df with integers 1 through 500
# Make another new column with the product of multiplying the values in this new column by those in the "numbers" column



##### Now we'll do it with the dplyr package ----
# try using functions in dplyr
library(dplyr) # read in the functions defined in the dplyr package




# you can do lots with dplyr
# compare the result of running these two lines:
head(df)
df %>% head

# The '%>%' operator is called 'pipe' and is just allows you to string together multiple
# function calls to do arbitrarily complext operations on a dataframe while still writing easily
# readable code
df %>% filter(numbers > 0) # keep only rows of df with values in the 'numbers' column greater than 0

df %>% filter(numbers > 0) %>% head # here's a trick for sanity checking your code to make sure it's doing what you expect
df %>% mutate(col1 = 1) %>% head # mutate adds a column, named "col1" in this case
df %>% mutate(col1 = 1, col2 = 2, col3 = col1+col2, col4 = col3*col2) %>% head # you can add multiple columns with a single call to mutate, and even use those columns within the call to mutate

df %>% summarize(numMean = mean(numbers)) # summarize returns any summary of the data you want as a single row

df %>% summarize(numMean = mean(numbers), numMed = median(numbers), numsd = sd(numbers)) # can get lots of summaries

df %>% 
  group_by(letters) %>% # way cool! you can group the data in df by a variable in the dataframe, 'letters' in this case
  summarize(numMean = mean(numbers), numMed = median(numbers), numsd = sd(numbers)) # then get summaries for each group

newDF = df %>%
  group_by(letters) %>%
  mutate(newCol = numbers+mean(ind)) # can also add columns using the data from each group
# In the above example, a separate mean(ind) is calculated for the data in each group of letters,
# and that mean is added to the data in the numbers column. The result is placed in a new column
# called 'newCol'
newDF %>% head
newDF %>% tail

# get the column names from a dataframe with 'names'
names(df)

# Let's plot some of that stuff ----
library(ggplot2) # read in the graphics package ggplot2
?ggplot

df %>% # send the data in df to our call to ggplot
  ggplot(aes(x=ind, y=numbers)) + # ggplot requires data, which we sent via '%>%' above, and a mapping, which is provided here with aes(x=blah, y=blahlBlah)
  geom_point() # calling ggplot alone won't generate a plot, we must now add "layers", such as geom_point to make a scatterplot
# There are many "geoms" we could use to make various types of plots
# There are also many different types of layers we can add to modify the way the data are plotted and the way those plots look

df %>%
  ggplot(aes(x=ind, y=numbers)) +
  geom_point() +
  facet_wrap(~letters) # make a separate subplot for each distinct letter found in the letters column

df %>%
  ggplot(aes(x=ind, y=numbers)) +
  geom_point() +
  facet_wrap(~letters, scales="free_x") # let's free up the x-axes of the subplots so that they are independent of each other

df %>%
  ggplot(aes(x=ind, y=numbers, color=letters)) + # Now we've added a color mapping to aes(), see what that does.
  geom_point()

# We can also direct the output of ggplot to a variable, like so:
p = df %>% #run this. Nothing seems to happen because the plot is placed into the variable p rather than being spit out on our screens
  ggplot(aes(x=ind, y=numbers)) +
  geom_point()

p # Now run THIS! The plot is made.

# We can add layers to an existing plot after we've stored it in a variable, like so:
p + facet_wrap(~letters, scales="free_x")
p + geom_line()
p + geom_line() + facet_wrap(~letters, scales="free_x")
p + geom_hline(yintercept = c(-2,2))
p + geom_hline(yintercept = c(-2,2), color="blue", linetype="dashed")

# There are many, many ways to customize your plots with ggplot2. Google is your friend!

# We can change more aspects of the appearance of our plots using "theme"
p + theme(panel.background = element_blank()) # make the background blank
# oops. that doesn't look so good
# let's add black axis lines
p2 = p +
  theme(panel.background = element_blank(),
        axis.line = element_line(color="black"))

p2 # better, but the axis numbers are gray
p2 = p2 + theme(axis.text = element_text(color="black"))
p2

# Now let's make the axis labels more interesting
p2 + labs(x="Boring numbers", y="Random stuff to plot")

# What's the distribution of our data. Should be normal since we used rnorm, but let's look with a histogram
# Guess what! geom_histogram does the job!
##### POP QUIZ!!!!! #####
# plot a histogram of the data in the numbers column using ggplot



