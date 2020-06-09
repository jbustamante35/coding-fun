# TensorFlow Tutorial with Real Data
# Analyze properties of Belgian traffic signs and classify them in 6 different categories
import tensorflow as tf
import os
from skimage import transform
from skimage import io
%matplotlib
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

print("Analyze properties of Belgian traffic signs and classify them in 6 different categories\n\n")


# Function to load data from images directory and sub-directories
def load_data(data_directory):
    # Get paths to sub-directories from parent directory
    directories = [d for d in os.listdir(data_directory)
                    if os.path.isdir(os.path.join(data_directory, d))]
    labels = []
    images = []
    for d in directories:
        label_directory = os.path.join(data_directory, d)
        fileNames = [os.path.join(label_directory, f)
                    for f in os.listdir(label_directory)
                    if f.endswith(".ppm")]
        for f in fileNames:
            images.append(io.imread(f))
            labels.append(int(d))
    return images, labels
    

# Set path to root directory and images directory    
#ROOT_PATH = "/home/yan-yan11/Dropbox/ComputerProgramming/SevenLanguagesCode/misc/python3/TensorFlow_tutorial"
ROOT_PATH = "./"
trainData_directory = os.path.join(ROOT_PATH, "SampleImages/Training")
testData_directory = os.path.join(ROOT_PATH, "SampleImages/Testing")

# Import images from Training dataset
print("Loading images from Training dataset...")
images, labels = load_data(trainData_directory)
#plt.imshow(images[0]) # Show first image to be sure import worked

# Convert images to numpy array
npImages = np.array(images)
size_labels = len(set(labels))
print("Loaded %d images" % size_labels)

print("Dimensions of all Training Images: %d" % npImages.ndim)
print("Size of all Training Images: %d" % npImages.size)
print("Number of images: %d" % size_labels)

# Simple figures to look at data [uncomment when needed]
#print("\nFirst image in set:")
#plt.imshow(npImages[1]) # Show first image to be sure import worked
print("\nThis histogram represents the distribution of traffic sign types:")
plt.hist(labels, size_labels)

# Import images at random? Why?
#sample_signs = [1, 5, 10, 100, 
#                1000, 2000, 1235, 2346, 
#                234, 23, 724, 788, 
#                892, 4211, 3221, 1254]
#sample_signs = (100*(np.random.rand(1,25))).round().astype(int)[0]
sample_signs = np.random.randint(1, npImages.size, size=(1, 25))[0] # 25 random signs from 1-4000
for i in range(len(sample_signs)):
    plt.subplot(5, 5, i+1)
    plt.axis('off')
    plt.imshow(images[sample_signs[i]])
    plt.subplots_adjust(wspace=0.5)
    print("shape: {0}, min: {1}, max: {2}".format(images[sample_signs[i]].shape,
                                                  images[sample_signs[i]].min(),
                                                  images[sample_signs[i]].max()))

plt.show()

# Get the unique labels 
print("Showing all unique labels...")
unique_labels = set(labels)

# Initialize the figure
plt.figure(figsize=(15, 15))

# Set a counter
i = 1

# For each unique label,
for label in unique_labels:
    # You pick the first image for each label
    image = images[labels.index(label)]
    # Define 64 subplots 
    plt.subplot(8, 8, i)
    # Don't include axes
    plt.axis('off')
    # Add a title to each subplot 
    plt.title("Label {0} ({1})".format(label, labels.count(label)))
    # Add 1 to the counter
    i += 1
    # And you plot this first image 
    plt.imshow(image)
    
# Show the plot
plt.show()

# Rescale the images in the `images` array to 28 x 28 pixels
print("Rescaling all images...")
images28 = [transform.resize(image, (28, 28), mode='constant') for image in images]

# Initialize the figure
plt.figure(figsize=(15, 15))

# Set a counter
i = 1

# For each unique label,
for label in unique_labels:
    # You pick the first image for each label
    image28 = images28[labels.index(label)]
    # Define 64 subplots 
    plt.subplot(8, 8, i)
    # Don't include axes
    plt.axis('off')
    # Add a title to each subplot 
    plt.title("Rescaled {0} ({1})".format(label, labels.count(label)))
    # Add 1 to the counter
    i += 1
    # And you plot this first image 
    plt.imshow(image28)
    
    