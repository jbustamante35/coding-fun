from __future__ import division

def getMonthFactor(argument):
    switcher = {
            'y' : 1.00,
            'm' : 12.00,
            'd' : 1/30
            }
    return switcher.get(argument, 1.00)
