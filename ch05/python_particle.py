# -*- coding: utf-8 -*-

class Particle(object):
    """ 単純なParticle型 """
    def __init__(self, m, p, v):
        self.mass = m
        self.position = p
        self.velocity = v
    def _get_momentum(self):
        return self.mass * self.velocity
    momentum = property(_get_momentum)