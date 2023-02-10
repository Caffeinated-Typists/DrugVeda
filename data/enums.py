from enum import Enum

class Status(Enum):
    Placed = 1
    Shipped = 2
    Delivered = 3
    Cancelled = 4


class Payment(Enum):
    Cash = 1
    Credit_Card = 2
    Debit_Card = 3
    Net_Banking = 4
    Paytm = 5
    PhonePe = 6
    Google_Pay = 7
    Amazon_Pay = 8
    UPI = 9

class Delivery(Enum):
    Delivery = 1
    Pickup = 2