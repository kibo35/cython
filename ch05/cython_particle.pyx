# -*- coding: utf-8 -*-

cdef class Particle(object):
    """ 単純なParticle拡張型 """
    cdef double mass, position, velocity
    def __init__(self, m, p, v):
        self.mass = m
        self.position = p
        self.velocity = v
    cpdef double get_momentum(self):
        return self.mass * self.velocity
    cdef double get_momentum_c(self):
        return self.mass * self.velocity
    property momentum:
        """ Particleのmomentumプロパティ """
        def __get__(self):
            """ momentumのゲッター """
            return self.mass * self.velocity
        def __set__(self, m):
            """ momentumのセッター """
            self.velocity = m / self.mass

cdef class CParticle(Particle):
    cdef double momentum
    def __init__(self, m, p, v):
        super(CParticle, self).__init__(m, p, v)
        self.momentum = self.mass * self.velocity
    cpdef double get_momentum(self):
        return self.momentum

class PyParticle(Particle):
    def __init__(self, m, p, v):
        super(PyParticle, self).__init__(m, p, v)
    def get_momentum(self):
        return super(PyParticle, self).get_momentum()

def add_momentums(particles):
    """ 粒子の運動量の合計を返す。 """
    total_mom = 0.0
    for particle in particles:
        total_mom += particle.get_momentum()
    return total_mom

def add_momentums_typed(list particles):
    """ 粒子の運動量の合計を返す。 """
    cdef:
        double total_mom = 0.0
        Particle particle
    for particle in particles:
        total_mom += particle.get_momentum()
    return total_mom

def add_momentums_typed_c(list particles):
    """ 粒子の運動量の合計を返す。 """
    cdef:
        double total_mom = 0.0
        Particle particle
    for particle in particles:
        total_mom += particle.get_momentum_c()
    return total_mom

def dispatch(Particle p not None):
    print p.get_momentum()
    print p.velocity
