import java.util.Scanner;

class App {
    public static void main(String args[]) {
       System.out.println("first programs");

       // float data type
       float radius1 = 0.00000000000863872078f;
        System.out.println(radius1);
        double radius = 0.00000000000863872078;
        System.out.println(radius);

        // char data type

        char letter = 'A';
        System.out.println(letter);

        char number_as_text = '6';
        System.out.println(number_as_text);

        char number = 65;
        System.out.println(number);

        // Boolean data type
        boolean part_time = true;
        System.out.println(part_time);

        // null data type
        String line;
        line = "";
        System.out.println("line is null" + line);

        // <variable type> <variable identifier> = initial value;
        // Group initializations
        int age = 10, height = 5;
        double radius2 = 2.34, area = 4.55; 

         // Printing the variables
         System.out.println( "age: " + age );
         System.out.println( "height: " + height );
         System.out.println( "radius: " + radius2 );
         System.out.println( "area: " + area );

         // working with user input key in
        Scanner scanner_one = new Scanner(System.in);

        System.out.println("Enter your name: ");
        String name = scanner_one.nextLine();
        System.out.println("Your name is: " + name);

        // exercise
       /*  Problem statement#
            Declare an int type variable, name it int_number and assign it a value of 1000.

            Declare a float type variable, name it float_number and assign it a value of 10.292.

            Declare a double type variable, name it double_number and assign it a value of 0.00000000000512365123.

            Declare a char type variable, name it char_name and assign it a value of N.

            Declare a boolean type variable, name it bool_accept and assign it a value of true.*/
            int int_number = 1000;
            float float_number = 10.292f;
            double double_number = 0.00000000000512365123;
            char char_name = 'N';
            boolean bool_accept = false;

            System.out.println("int_number: " + int_number);
           
            System.out.println("float_number: " + float_number );

            System.out.println("double_number: " + double_number);

            System.out.println("char_name: " + char_name);

            System.out.println("bool_accept: " + bool_accept);

        }
}
