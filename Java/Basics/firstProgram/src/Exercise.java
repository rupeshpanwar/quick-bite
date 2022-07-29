public class Exercise {
           // Challenge 2: Compute an Expression Using Logical Operators
         /* 
          The method takes in two variables and computes a logical expression using them. For explanation’s sake, the parameters are called x and y.

        Now you must do the following:

        Find the Boolean NOT of x
        Boolean XOR the result of above with x itself
        Find the Boolean AND of the above answer with y
        Return the Boolean NOT of the entire expressions

            boolean x = true;
        boolean y = true;
        boolean answer;

        boolean not_x = !x;
        boolean xor_x = not_x ^ x;
        boolean and_xy = xor_x && y;
        answer = !and_xy;

        System.out.println(answer);
        
         */

        public static boolean exercise_two(boolean x, boolean y) {
            boolean answer = false;
    
           
            // Find the Boolean NOT of x
            answer = !x;
            System.out.println(answer);

            // Boolean XOR the result of above with x itself
            answer = answer^x;
            System.out.println(answer);

            // Find the Boolean AND of the above answer with y
            answer = answer && y;
            System.out.println(answer);

            // Calculate the value of an expression and store the final value in the answer
            answer = !(y && (x ^ !x));
            /* You do not need to worry too much about the return statement for the 
            moment and just set the value of “answer” correctly*/
            System.out.println(answer);

            return answer;
        }
      
}
