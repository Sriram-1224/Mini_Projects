import java.util.*;
public class PasswordValidator{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        boolean valid_password = false;
        while (!valid_password){
            System.out.print("Enter your password : ");
            String password=sc.nextLine();
            boolean contains_UpperCase=false;
            boolean contains_Digit=false;
            if(password.length()<8){
                System.out.println("=> Password is Too short.");
            }
            for(int i=0;i<password.length();i++){
                char ch= password.charAt(i);
                if(Character.isUpperCase(ch)){
                    contains_UpperCase=true;
                }
                if(Character.isDigit(ch)){
                    contains_Digit=true;
                }
            }
            if(!contains_UpperCase){
            System.out.println("=> Missing an UpperCase letter.");
            }
            if(!contains_Digit){
                System.out.println("=> Missing a Digit.");
            }

            if(password.length()>=8 && contains_Digit && contains_UpperCase){
                System.out.println("Password is Valid..!");
                valid_password=true;
            }else{
                System.out.println("Please try again..!");
            }
        }
        sc.close();
    }
}