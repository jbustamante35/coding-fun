import numpy as np 
import matplotlib.pyplot as plt 

# Load data
X = []
Y = []

for line in open('data_1d.csv'):
    x,y = line.split(',')
    X.append(float(x))
    Y.append(float(y))

# Convert to numpY arraYs
X = np.array(X)
Y = np.array(Y)

# Plot X and Y
plt.scatter(X,Y)
plt.show()

# Apply equations from previous lessons
denominator = X.dot(X) - X.mean() * X.sum() 
a           = (X.dot(Y) - Y.mean() * X.sum()) / denominator
b           = (Y.mean() * X.dot(X) - X.mean() * X.dot(Y)) / denominator

# Calculate predicted Y
Yhat = a * X + b
plt.scatter(X,Y)
plt.plot(X,Yhat)
plt.show()
