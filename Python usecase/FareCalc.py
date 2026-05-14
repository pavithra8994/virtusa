rates = {
    "Economy": 10,
    "Premium": 18,
    "Suv": 25
}



def calculate_fare(km, vehicle_type, hour):

    
    if vehicle_type not in rates:
        return "Service Not Available"

    
    
    base_rate = rates[vehicle_type]
    total = km * base_rate

    
    if 17 <= hour <= 20:
        total *= 1.5
        surge_applied = True
    else:
        surge_applied = False

    return total, surge_applied



try:
    print("-------- CityCab Ride Estimate ---------")

   
    km = float(input("Enter distance (in km): "))
    vehicle_type = input("Enter vehicle type (Economy/Premium/Suv): ")
    hour = int(input("Enter hour of travel (0-23): "))

    
    if km < 0:
        print("Invalid distance! Distance cannot be negative.")

    
    elif hour < 0 or hour > 23:
        print("Invalid hour! Please enter between 0 and 23.")

    else:
        
        result = calculate_fare(km, vehicle_type, hour)

        
        if result == "Service Not Available":
            print("Service Not Available for selected vehicle type.")

        
        elif result == "Invalid distance":
            print("Invalid distance! Distance cannot be negative.")

        else:
            total, surge = result

            
            print("------ PRICE RECEIPT ------")
            print("Distance       :", km, "km")
            print("Vehicle Type   :", vehicle_type)
            print("Base Rate/km   : ₹", rates[vehicle_type])

            if surge:
                print("Surge Applied  : Yes (1.5x)")
            else:
                print("Surge Applied  : No")

            print("Total Fare     : ₹{:.2f}".format(total))
            print("---------------------------")



except ValueError:
    print("Invalid input! Please enter correct numeric values.")




