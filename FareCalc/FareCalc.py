# FareCalc - Travel Optimizer

# Step 1: Dictionary for vehicle rates
rates = {
    "Economy": 10,
    "Premium": 18,
    "SUV": 25
}

# Step 3: Function to calculate fare
def calculate_fare(km, vehicle_type, hour):
    
    # Step 4: Error Handling
    if vehicle_type not in rates:
        return "Service Not Available"
    
    base_rate = rates[vehicle_type]
    total = km * base_rate
    
    # Step 2: Surge Pricing Logic
    if 17 <= hour <= 20:
        total *= 1.5
        surge_applied = True
    else:
        surge_applied = False
    
    return total, surge_applied


# -------- MAIN PROGRAM --------
try:
    print("\n===== CityCab Ride Estimate =====")
    
    km = float(input("Enter distance (in km): "))
    vehicle_type = input("Enter vehicle type (Economy/Premium/SUV): ")
    hour = int(input("Enter hour of travel (0-23): "))
    
    result = calculate_fare(km, vehicle_type, hour)
    
    # If invalid vehicle type
    if result == "Service Not Available":
        print("\n Service Not Available for selected vehicle type.")
    
    else:
        total, surge = result
        
        print("\n===== PRICE RECEIPT =====")
        print(f"Distance       : {km} km")
        print(f"Vehicle Type   : {vehicle_type}")
        print(f"Base Rate/km   : ₹{rates[vehicle_type]}")
        
        if surge:
            print("Surge Applied  : Yes (1.5x)")
        else:
            print("Surge Applied  : No")
        
        print(f"Total Fare     : ₹{total:.2f}")
        print("=============================")

except ValueError:
    print("\n Invalid input! Please enter correct numeric values.")