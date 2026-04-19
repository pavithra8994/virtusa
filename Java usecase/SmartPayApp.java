import java.util.Scanner;


interface Billable {
    double calculateTotal();
}


class UtilityBill implements Billable {

    String customerNameName;
    int prevReading;
    int currReading;
    int units;
    double totalAmount;

    
    UtilityBill(String name, int prev, int curr) {
        this.customerName = name;
        this.prevReading = prev;
        this.currReading = curr;
    }

    
    public double calculateTotal() {

        units = currReading - prevReading;
        double amount = 0;

        
        if (units <= 100) {
            amount = units * 1.0;
        } else if (units <= 300) {
            amount = (100 * 1.0) + ((units - 100) * 2.0);
        } else {
            amount = (100 * 1.0) + (200 * 2.0) + ((units - 300) * 5.0);
        }

        
        double tax = amount * 0.10;
        totalAmount = amount + tax;

        return totalAmount;
    }

    
    void print() {
        System.out.println("\n---------SMARTPAY RECEIPT--------");
        System.out.println("Name : " + customerName);
        System.out.println("Units Consumed: " + units);
        System.out.println("Total Amount  : $" + totalAmount);
        System.out.println("============================");
    }
}

// Main class
public class SmartPayApp {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        while (true) {

            System.out.print("\nEnter  Name (or type Exit): ");
            String name = sc.nextLine();

            
            if (name.equalsIgnoreCase("Exit")) {
                System.out.println("Exiting Application...");
                break;
            }

            System.out.print("Enter Previous Reading: ");
            int prev = sc.nextInt();

            System.out.print("Enter Current Reading: ");
            int curr = sc.nextInt();
            sc.nextLine(); 

            
            if (prev > curr) {
                System.out.println("Error: Previous reading cannot be greater than current reading!");
                continue;
            }

            
            UtilityBill bill = new UtilityBill(name, prev, curr);

            
            bill.calculateTotal();
            bill.print();
        }

        sc.close();
    }
}
