# Try out TensorFlow functions from Datacamp Tutorial https://www.datacamp.com/community/tutorials/tensorflow-tutorial#gs.ynRYsHU

import tensorflow as tf

print("Good luck on your first attempts at using TensorFlow!\n\n")

# Initialze and multiply 2 array constants
n1 = tf.constant([-1,0,1,2,3,4])
n2 = tf.constant([5,6,7,8,9,10])
multiplyConstants = tf.multiply(n1, n2)
print("Print the model for the product of both tensors:")
print(multiplyConstants)

# Initialize and Close a sess1ion
sess1 = tf.Session()
print("\nReadable product of both vectors:")
print(sess1.run(multiplyConstants))
sess1.close()

# Initialize interactive sess1ion
with tf.Session() as sess2:
    output = sess2.run(multiplyConstants)
    print("\nInitialize an Interactive Session")
    print(output)
    sess2.close()
    



