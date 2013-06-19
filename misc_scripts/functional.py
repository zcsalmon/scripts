import re
import sys

def Adder( arg1, arg2 ):
    result = arg1 + arg2
    #print result
    return result;
    
    


array_list1 = [2, 4, 9, 15]
array_list2 = [3, 6, 10, 16]
i=0
while (i < 4):
    Adder(array_list1[i], array_list2[i])
    i = i + 1