# -*- coding: utf-8 -*-

cdef class E:
    """ 加算をサポートするクラス """
    cdef int data
    def __init__(self, d):
        self.data = d
    def __add__(x, y):
        # 通常の__add__の動作
        if isinstance(x, E):
            if isinstance(y, int):
                return (<E>x).data + y
        # __radd__の動作
        elif isinstance(y, E):
            if isinstance(x, int):
                return (<E>y).data + x
        else:
            return NotImplemented

from cpython.object cimport Py_LT, Py_LE, Py_EQ, Py_GE, Py_GT, Py_NE

cdef class R:
    """ リッチ比較をサポートする拡張型 """
    cdef double data
    def __init__(self, d):
        self.data = d

    def __richcmp__(x, y, int op):
        cdef:
            R r
            double data
        # rはいつもRのインスタンスを指す。
        r, y = (x, y) if isinstance(x, R) else (y, x)

        data = r.data
        if op == Py_LT:
            return data < y
        elif op == Py_LE:
            return data <= y
        elif op == Py_EQ:
            return data == y
        elif op == Py_NE:
            return data != y
        elif op == Py_GT:
            return data > y
        elif op == Py_GE:
            return data >= y
        else:
            assert False

cdef class I:
    cdef:
        list data
        int i
    def __init__(self):
        self.data = range(100)
        self.i = 0
    def __iter__(self):
        return self
    def __next__(self):
        if self.i >= len(self.data):
            raise StopIteration()
        ret = self.data[self.i]
        self.i += 1
        return ret

