import csv
import os
import matplotlib.pyplot as mt

FILE_NAME = "expenses.csv"

def create_file():
    if os.path.exists(FILE_NAME):
        print("File already exists")
    else:
        file=open(FILE_NAME,"w",newline="")
        writer=csv.writer(file)
        writer.writerow(["Date","Category","Amount","Description"])
        file.close()
        print("File created Successfully.")

def add_expense():
    categories=["Food","Travel","Bills","Shopping","Health","Education","Entertainment","Rent","Groceries","Fuel","Others"]
    date=input("Enter Date (DD-MM-YYYY) : ")
    print("\n----- Available Categories -----")
    for i in range(len(categories)):
        print(i+1,".",categories[i])
    while True:
        choice=int(input("Select Category Number : "))
        if choice>=1 and choice<=len(categories):
            category=categories[choice-1]
            break
        else:
            print("Invalid Category -- Please select correctly.")        
    amount = float(input("Enter Amount : "))
    description = input("Enter a description : ")
    
    file=open(FILE_NAME,"a",newline="")
    writer=csv.writer(file)
    writer.writerow([date,category,amount,description])

    file.close()
    print("Expense added successfully.")

def view_expenses():
    file=open(FILE_NAME,"r")
    reader=csv.reader(file)
    
    print("\n------ All Expenses ------")
    for i in reader:
        print("Date: ",i[0],"| Category: ",i[1],"| Amount: ",i[2],"| Description: ",i[3])

    file.close()


def monthly_summary():
    month=input("Enter month and year (MM-YYYY) : ")
    total=0
    category_total={}

    file=open(FILE_NAME,"r")
    reader=csv.DictReader(file)

    for i in reader:
        expense_month=i["Date"][3:]
        if expense_month==month:
            amount=float(i["Amount"])
            category=i["Category"]

            total=total+amount

            if category in category_total:
                category_total[category]=category_total[category]+amount
            else:
                category_total[category]=amount
    file.close()

    print("\n------ Monthly Summary ------")
    print("Total Expense: ₹",total)
    if(len(category_total))>0:
        print("\nCategory Breakdown : ")
        for category in category_total:
            print(category,": ₹",category_total[category])

        highest=max(category_total,key=category_total.get)
        print("\nHighest Spending Category : ",highest)
        print("Try reducing expenses in ",highest)
        pie_chart(category_total)
    else:
        print("No expenses found.")                                                

def pie_chart(category_total):
    categories=list(category_total.keys())
    amounts=list(category_total.values())

    mt.figure(figsize=(6,6))
    mt.pie(amounts,labels=categories,autopct="%1.1f%%")
    mt.title("Expense Breakdown based on Category")
    mt.show()
    

def main():
    create_file()
    while True:
        print("\n------ Smart Expense Tracker ------")
        print("1. Add an Expense")  
        print("2. View my Expenses")
        print("3. Monthly Summary")
        print("4. Exit")

        i = input("Enter your choice : ")
        if i=="1":
            add_expense()
        elif i=="2":
            view_expenses()
        elif i=="3":
            monthly_summary()            
        elif i=="4":
            print("Expense Tracker Closed.!")
            break
        else:
            print("Invalid choice.")

main()                                      