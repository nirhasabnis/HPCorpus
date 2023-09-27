**HOW TO USE**

1. Use `get_hpcorpus_c_funcs.py` script to generate a directory containing C code.
```
$ mkdir /tmp/c_funcs
$ python get_hpcorpus_c_funcs.py <hpcorpus_json> /tmp/c_funcs
```

This will produce `N` .C programs under `/tmp/c_funcs`, each program for a C function from input JSON file.

2. Check if every C program can be compiled without error.
```
$ ./try_compile_c_funcs.sh /tmp/c_funcs /tmp/log
```

Output `/tmp/log` will contain a list of C programs and their compilation status, with `0` meaning success and `1` for failure.

*NOTE* Install GNU Parallel, if you don't have one. It helps with parallel execution on multi-core CPUs.
