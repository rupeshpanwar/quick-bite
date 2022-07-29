public class Operator {
    public static void main(String[] args) {
       // With mathematical operations, the precedence follows the rule of BODMAS, which says; Brackets, Order, Division, Multiplication, Addition, and then Subtraction.
        int answer; 

        System.out.println("ADDITION");
        int add = 20;

        System.out.println("Initial value: " + add);
        answer = add + 2;
        System.out.println("add + 2 = " + answer);
        answer = add;
        System.out.println("add = " + answer);
        System.out.println();

        System.out.println("SUBTRACTION");
        int sub = 15;

        System.out.println("Initial value: " + sub);
        System.out.println("sub - 4 = " + (sub - 4));
        System.out.println("sub = " + sub);
        System.out.println();

        System.out.println("MULTIPLICATION");
        int mult = 25;

        System.out.println("Initial value: " + mult);
        answer = mult * 3;
        System.out.println("mult * 3 = " + answer);
        answer = mult;
        System.out.println("mult = " + mult);
        System.out.println();

        System.out.println("DIVISION (INT)");
        int div_int = 15;

        System.out.println("Initial value: " + div_int);
        System.out.println("div_int / 2 = " + (div_int / 2));
        System.out.println("div_int = " + div_int);
        System.out.println();

        System.out.println("MODULO (REMINDER)");
        int rem = 5;

        System.out.println("Initial value: " + rem);
        answer = rem % 2;
        System.out.println("rem % 2 = " + answer);
        answer = rem;
        System.out.println("rem = " + answer);
        System.out.println();

        System.out.println("PREINCREMENT BY ONE");
        int pre_inc = 5;

        System.out.println("Initial value: " + pre_inc);
        System.out.println("++pre_inc   = " + (++pre_inc));
        System.out.println("pre_inc = " + pre_inc);
        System.out.println();

        System.out.println("PREDECREMENT BY ONE");
        int pre_dec = 5;

        System.out.println("Initial value: " + pre_dec);
        answer = --pre_dec;
        System.out.println("--pre_dec   = " + answer);
        answer = pre_dec;
        System.out.println("pre_dec = " + answer);
        System.out.println();

        System.out.println("POST INCREMENT BY ONE");
        int post_inc = 5;

        System.out.println("Initial value: " + post_inc);
        System.out.println("post_inc++   = " + (post_inc++));
        System.out.println("post_inc = " + post_inc);
        System.out.println();

        System.out.println("POSTDECREMENT BY ONE");
        int post_dec = 5;

        System.out.println("Initial value: " + post_dec);
        answer = post_dec--;
        System.out.println("post_dec--   = " + answer);
        answer = post_dec;
        System.out.println("post_dec = " + answer);
        System.out.println();


        // Bodmas mathematical
        int x = 5;
        int y = 10;
        int z = 7;
        int w = 6;
        int answer2;

        System.out.println("x: " + x);
        System.out.println("y: " + y);
        System.out.println("z: " + z);
        System.out.println("w: " + w);

        System.out.println("Calculating Expressions with Multiple Operators");

        System.out.println("(x-z) + y*y = " + ((x - z) + y * y));
        answer2 = (w / y + (x * z));

        System.out.println("w/y + (x*z) = " + answer2);

      /*   Operator associativity determines whether, in an expression, if there are multiple operators like (1 + 2 - 5), how will they be evaluated if they are of the same precedence. The addition + and subtraction - have left associativity.

        x + y - z
        The part x + y will be evaluated first, which will give us 15
        Then it will calculate 15 - 7 and hence give the final answer 8 */
        int x1 = 5;
        int y1 = 10;
        int z1 = 7;

        int answer3;

        System.out.println("x: " + x1);
        System.out.println("y: " + y1);
        System.out.println("z: " + z1);

        System.out.println("Calculating Expression containing operators the with same precedence");

        answer3 = x1+y1-z1;

        System.out.println("x+y-z = " + answer3);

        // Mathematical Functions

        System.out.println("2 raised to the power 3 is " + Math.pow(2, 3));
        System.out.println("Exponent squared is " + Math.exp(2));
        System.out.println("The square root of 16 is " + Math.sqrt(16));
        System.out.println("The cube root of 27 is " + Math.cbrt(27));

        System.out.println("log of 2 is " + Math.log(2));
        System.out.println("log to the base 10 of 100 is " + Math.log10(100));

        System.out.println("tan(45) =" + Math.tan(Math.toRadians(45)));
        System.out.println("sin(45) =" + Math.sin(Math.toRadians(45)));
        System.out.println("cos(45) =" + Math.cos(Math.toRadians(45)));

        System.out.println("Absolute value of -2: " + Math.abs(-2));
        System.out.println("Absolute value of 2: " + Math.abs(2));

        System.out.println("Maximum between 2.04 and 2.05: " + Math.max(2.04, 2.05));
        System.out.println("Minimum between 2 and 23: " + Math.min(2, 23));

        //Logical Expressions
        int xx = 5;
        int yy = 10;

        System.out.println("x is equal to: " + xx);
        System.out.println("y is equal to: " + yy);

        System.out.println("x is greater than y");
        System.out.println(x > y);

        System.out.println("x is less than y");
        System.out.println(x < y);

        System.out.println("x is greater than or equal to y");
        System.out.println(x >= y);

        System.out.println("y is less than or equal to y");
        System.out.println(y <= y);

        System.out.println("x is equal to y");
        System.out.println(x == y);

        System.out.println("x is not equal to y");
        System.out.println(x != y);


        // Boolean operations
        boolean xxx = true;
        boolean yyy = false;

        System.out.println("Value of x: " + xxx);
        System.out.println("Value of y: " + yyy);

        System.out.println("Boolean NOT of x");
        System.out.println(!xxx);

        System.out.println("Boolean AND of x and y");
        System.out.println(xxx && yyy);

        System.out.println("Boolean OR of x and y");
        System.out.println(xxx || yyy);

        System.out.println("Boolean exclusive XOR of x and y");
        System.out.println(xxx ^ yyy);

        /*
         Coding exercise#
         
            Write a code in which you:

                    First, compute the respective powers of two floating-point variables x and y.
                    Then Add them after taking powers.
                    Then, compute the absolute value of floating-point z.
                    Subtract this from the above-computed addition value.
                    Now take Cube Root of the answer.
                    Use inbuilt functions to calculate this expression

                      double x = 55.0;
                    double y = 18.0;
                    double z = 51.0;
                    double answer;
                    double sum = Math.pow(x, 2) + Math.pow(y, 2);
                    double sub = sum - Math.abs(z);
                    answer = Math.cbrt(sub);
                    System.out.println(answer);
         */

         double pow_x = Math.pow(2, 2);
         double pow_y = Math.pow(3, 3);
         double sum = pow_x + pow_y;
         float abs_z = Math.abs(15.00f);

         double result = sum - abs_z;
         double cbrt = Math.cbrt(result);

         System.out.println("pow_x=" + pow_x + ", pow_y=" + pow_y + ", CBRT" + cbrt);

  
    }
}
