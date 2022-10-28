# Extracting Data from PDF

import PyPDF2
import re

stryker_file = (r"C:\Users\PC\Documents\Prospect Data\Stryker_Invoices\Stryker.pdf")

doc = PyPDF2.PdfFileReader(stryker_file)

pages = doc.getNumPages()

# print(pages)

#Search term
search = (r'CCHP\d{6}')

#List of Tuples (display all occurences, and page numbers)
list_pages = []

for i in range(pages):
    current_page = doc.getPage(i)
    text = current_page.extractText()
    #print(text)
    if  re.findall(search, text):
        print(re.findall(search, text))
        #count_page = len(re.findall(search, text))
        #list_pages.append((count_page, i))

#Result
#print(list_pages)

#Number of pages that contains search term
count = len(list_pages)

#print(count)