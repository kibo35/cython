from libc.math cimport sin

cpdef double run_sin(double x):
    return sin(x)