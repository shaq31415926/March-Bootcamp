import os

os.system("clear")

print("Welcome to My Area of Rectangle Calculator")

# the input function is a handy function that lets you ask the user information
height=int(input("What is the height (cm)?:"))
width=int(input("What is the width (cm)?:"))
# we wrap this an integer, otherwise it gets picked up as a string

# this calculates the area of the variable
area=height*width

print(f"The area of the rectangle is {area} cm2")
#print("The area of the rectangle is", area)
