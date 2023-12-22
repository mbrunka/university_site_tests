from robot.api.deco import keyword
from random import randint
from datetime import datetime


@keyword("Generate Random Number")
def gen_random_nb(nb_len):
    sum = 0
    for x in range(0, int(nb_len)):
        sum += randint(0, 9) * (10 ** int(x))
    return sum

@keyword("Get Current Year")
def get_current_year():
    return datetime.now().year