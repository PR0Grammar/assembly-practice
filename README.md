# floatToIntSum

An assembly program that determines if a value entered, N, is a float or int depending on its binary representation. If a float is entered, the number will be truncated to an integer,M, and the sum of 1 - M is found. If an integer is entered, the sum of 1 - N is found.

### NOTE: 
The input value is stored in a single precision float register, so by default all values entered are considered floats. The program consideres N as an integer if the input value is either 'N.0 - N.0000000' or 'N.' or 'N'
