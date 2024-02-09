# Instances for ``A branch, bound and remember algorithm for maximizing the production rate in the simple assembly line balancing problem'' (under review) 

This repository contains the base instances used in the paper and codes to derive new instaces.

Folders scholl and otto contain the original instances provided by the abovementioned authors (you can download from their webpage at [https://assembly-line-balancing.de/][https://assembly-line-balancing.de/]

There are two c programs to generate the instances used in this work from the original instances:

- in2alb.c: Converts from classical file format (.IN2) to alternative .ALB format. It also includes the number of workstations and calculates the order strength.
- otto.c : Subsets .ALB files and adds number of workstations.

Both codes are self-contained (even if it means some repeated code) and can be easily compiled with gcc (i.e., gcc -o otto otto.c)

Please note that these codes were not made thinking on efficiency and this comes at a price when used (i.e., it calculates the order strength even if it is a known parameter if no subsetting is performed).

There are also two shell scripts to generate the instances

- generateScholl.sh: Creates the 302 classical SALBP-2 instances and outputs them in .ALB format.
- generateOtto.sh: Creates 11 SALBP-2 instances for each initial instance according to the number of tasks. It also generates instances with 150, 200, 250 and 500 tasks by subsetting very large (n=1000) instances.

If you want to generate only some of these instances, please change the shell script.

