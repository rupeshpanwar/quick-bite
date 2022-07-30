public class stringlisterals {
    public static void main(String[] args) {
        String special_char = "Line one\n" + "Line two\n";
        System.out.println(special_char);

        // immutable , String objects are immutable, i.e, they cannot be modified once created.

        String text = "       Cut string";
        // The trim function is meant to eliminate leading & trailing spaces
        text.trim();
        // Without assigning the text variable to the trimmed string
        System.out.println(text);

        // Assigning trimmed string to the variable
        text = text.trim();
        System.out.println(text);

        // String concatenation
        String one = "Hello";
        String two = " World";
        int number = 10;

        // concatenating two strings
        System.out.println(one + two);

        //concatenating a number and string
        System.out.println(one + " " + number);

        //saving concatenated string and printing
        String new_string = one + two + " " + number;
        System.out.println(new_string);

        //Comparing strings#
        String helloone = "Hello";
        String hellotwo = "World";
        String lower = "hello";
        String same = "Hello";

        System.out.println(helloone.equals(hellotwo));

        System.out.println(one.equals(lower));

        System.out.println(one.equals(same));

        //Splitting a string#
        String greet = "Hello World,My name is Rupesh,How are you?";
        String[] greetings = greet.split(",");
        System.out.println(greetings[0]);
        System.out.println(greetings[1]);
        System.out.println(greetings[2]);

        //Substrings
        String choice = "CoffeeOrTea";
        //First: Only one argument
        System.out.println(choice.substring(8));

        //Second: Two arguments
        System.out.println(choice.substring(0, 6));


        String greeting = "HeLlo WoRld";

        //Returns new string in which all characters are converted to upper case
        System.out.println(greeting.toUpperCase());

        //Returns new string in which all characters are converted to lower case
        System.out.println(greeting.toLowerCase());

        // Len
        String greets = "Hello World";
        System.out.println("The length of greeting is: " + greets.length());

       /*
        Coding exercise#
This challenge will test your understanding of all String knowledge that you have learned. The following steps must be done in that order and on the result from the previous step.

1- Remove all the leading and trailing spaces from the given string.

2- Take the result of step 1 and extract all characters between index 0 and 5 inclusive.

3- Take the result of step 2 and convert all letters to uppercase
        */
        String answer = "  letters needs to be trimmer in ";
        answer = answer.trim();

        // Enter your code here
        // Store your final result in the variable answer
        answer = answer.substring(0, 5); 
        System.out.println(answer.toUpperCase());
        /* You do not need to worry too much about the return statement for the 
        moment and just set the value of “answer” correctly*/
        
    }
    
}
