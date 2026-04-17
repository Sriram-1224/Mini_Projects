# FareCalc - My Travel Optimizer

Rates_per_km = {
    'Economy': 10,
    'Premium': 18,
    'SUV': 25
}

def calculate_fare(km, Type_of_Vehicle, time_slot):
    if Type_of_Vehicle not in Rates_per_km:
        raise ValueError("Service Not Available")
    
    base_cost = km * Rates_per_km[Type_of_Vehicle]

    if 17 <= time_slot <= 20:
        Surge_Multiplier = 1.5
    else:
        Surge_Multiplier = 1.0

    Final_Fare = base_cost * Surge_Multiplier

    return round(Final_Fare,2), Surge_Multiplier , base_cost    

def main():
    print("======== City Cab ========")

    try:
        km = float(input("Enter distance (in km): ").strip())
        Type_of_Vehicle = input("Enter Vehicle type (Economy/Premium/SUV): ").strip()
        time_slot = int(input("Enter hour of the day (0-23): ").strip())

        if km <=0:
            print("Invalid Distance. Must be greater than 0.")
            return
        
        if not (0<=time_slot<=23):
            print("Invalid hour. Must be between 0 and 23.")
            return
        
        Fare, Surge ,Base_Fare = calculate_fare(km, Type_of_Vehicle , time_slot)

        print("\n============ Price Receipt ============")
        print(f"Distance            :   {km} km")
        print(f"Type of Vehicle     :   {Type_of_Vehicle}")
        print(f"Rate per km         :   ₹{Rates_per_km[Type_of_Vehicle]}")
        print(f"Base Fare           :   ₹{Base_Fare:.2f}")
        print(f"Surge Multiplier    :   x{Surge}")
        print(f"Total Fare          :   ₹{Fare:.2f}")
        print("============ Thank you :) ============")
        
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception:
        print("Unexpected error occured. Please try again.")        

main()