from enum import Enum

class Status(Enum):
    Placed = 'Placed'
    Shipped = 'Shipped'
    Delivered = 'Delivered'
    Cancelled = 'Cancelled'


class Payment(Enum):
    Cash = 'Cash'
    Credit_Card = 'Credit Card'
    Debit_Card = 'Debit Card'
    Net_Banking = 'Net Banking'
    Paytm = 'Paytm'
    PhonePe = 'PhonePe'
    Google_Pay = 'Google Pay'
    Amazon_Pay = 'Amazon Pay'
    UPI = 'UPI'

class Delivery(Enum):
    Delivery = 'Delivery'
    Pickup = 'Pickup'

