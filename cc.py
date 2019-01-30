from bs4 import BeautifulSoup
from urllib.request import urlopen


amount = input("Enter the amount: ")
from_curr = input("Convert from: ")
to_curr = input("Convert to: ")

website = "https://www.x-rates.com/calculator/?from=" + from_curr + "&to=" + to_curr + "&amount=1"
page = urlopen(website)
soup = BeautifulSoup(page, 'html.parser')
rate = float((soup.find('span', attrs={'class': 'ccOutputRslt'}).text.split())[0])
total = rate * float(amount)
print("\n###########################################")
print("#\n#\t1 " + from_curr + " = " + str(rate) + " " + to_curr)
print("#\t" + amount + " " + from_curr + " = " + str(total) + " " + to_curr)
print("#\n###########################################\n")
