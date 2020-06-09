from fetchAndLoad_housing_data import fetchAndLoad_housing_data
import os

# Actual URL from copy-pasting github site
ACTUAL_ROOT = "https://github.com/ageron/handson-ml/"
ACTUAL_PATH = "blob/master/datasets/housing"
ACTUAL_URL = ACTUAL_ROOT + ACTUAL_PATH + "/housing.tgz"

# URL from book (this seems to be the correct one still, despite actual url being incorrect)
DOWNLOAD_ROOT = "https://raw.githubusercontent.com/ageron/handson-ml/master/"
HOUSING_PATH = os.path.join("datasets", "housing")
HOUSING_URL = DOWNLOAD_ROOT + "datasets/housing/housing.tgz"

# Fetch and Load housing data
housing = fetchAndLoad_housing_data(HOUSING_URL, HOUSING_PATH)
print(housing.head())
print(housing.tail())
print(housing.info())
print(housing.all())
print(housing.population)

for p in range(0,len(housing.population)):
    print("{0}".format(p))