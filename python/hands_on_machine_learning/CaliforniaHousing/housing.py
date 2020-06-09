import os
import tarfile
import pandas as pd
from six.moves import urllib

def fetch_housing_data(housing_url, housing_path):
    if not os.path.isdir(housing_path):
        os.makedirs(housing_path)
    tgz_path = os.path.join(housing_path, "housing.tgz")
    urllib.request.urlretrieve(housing_url, tgz_path)
    housing_tgz = tarfile.open(tgz_path)
    housing_tgz.extractall(path=housing_path)
    housing_tgz.close()

def load_housing_data(housing_path):
    csv_path = os.path.join(housing_path, "housing.csv")
    print(csv_path)
    return pd.read_csv(csv_path)

#def fetchAndLoad_housing_data(housing_url, housing_path):
#    fetch_housing_data(housing_url, housing_path)
#    print(housing_url + " " + housing_path)
#    return load_housing_data(housing_path) 


# Actual URL from copy-pasting github site
ACTUAL_ROOT = "https://github.com/ageron/handson-ml/"
ACTUAL_PATH = "blob/master/datasets/housing"
ACTUAL_URL = ACTUAL_ROOT + ACTUAL_PATH + "/housing.tgz"

# URL from book (this seems to be the correct one still, despite actual url being incorrect)
DOWNLOAD_ROOT = "https://raw.githubusercontent.com/ageron/handson-ml/master/"
HOUSING_PATH = os.path.join("datasets", "housing")
HOUSING_URL = DOWNLOAD_ROOT + "datasets/housing/housing.tgz"

# Fetch and Load housing data
housing = load_housing_data(HOUSING_PATH)
print(housing.head())