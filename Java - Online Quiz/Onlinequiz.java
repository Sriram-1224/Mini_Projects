import java.util.*;
import java.io.*;
class Questions{
    String question;
    String A;
    String B;
    String C;
    String D;
    char Answer;

    public Questions(String question,String A,String B,String C,String D,char Answer){
        this.question=question;
        this.A=A;
        this.B=B;
        this.C=C;
        this.D=D;
        this.Answer=Answer;
    }

    public String toFileString(){
        return question + "|" + A + "|" + B + "|" + C + "|" + D + "|" + Answer;
    }
}

class FileManager{
    private static final String FILE_NAME="questions.txt";

    public static void saveQuestion(Questions q){
        try(FileWriter fw = new FileWriter(FILE_NAME,true)){
            fw.write(q.toFileString()+"\n");
        }catch(IOException ie){
            System.out.println("Error saving question.!");
        }
    }

    public static ArrayList<Questions> loadQuestions(){
        ArrayList<Questions> list=new ArrayList<>();
        
        try(BufferedReader br = new BufferedReader(new FileReader(FILE_NAME))){
            String line;
            while((line = br.readLine())!=null){
                String[] p = line.split("\\|");
                if(p.length == 6){
                    Questions q=new Questions(p[0],p[1],p[2],p[3],p[4],p[5].charAt(0));
                    list.add(q);
                }
            }
        }catch(IOException ie){
            System.out.println("No questions found.!");
        }
        return list;
    }
}

class Admin{
    Scanner sc=new Scanner(System.in);
    private final String USERNAME = "admin";
    private final String PASSWORD = "admin@123";

    public boolean login() {
        System.out.print("Enter Username: ");
        String user = sc.nextLine();

        System.out.print("Enter Password: ");
        String pass = sc.nextLine();

        if(user.equals(USERNAME) && pass.equals(PASSWORD)) {
            System.out.println("Login Successful!\n");
            return true;
        } else {
            System.out.println("Invalid Credentials!\n");
            return false;
        }
    }

    public void addQuestion(){
        System.out.print("Enter question: ");
        String q = sc.nextLine();

        System.out.print("Option A: ");
        String a = sc.nextLine();

        System.out.print("Option B: ");
        String b = sc.nextLine();

        System.out.print("Option C: ");
        String c = sc.nextLine();

        System.out.print("Option D: ");
        String d = sc.nextLine();

        System.out.print("Correct Answer (A/B/C/D): ");
        char ans = sc.nextLine().toUpperCase().charAt(0);

        Questions question = new Questions(q, a, b, c, d, ans);

        FileManager.saveQuestion(question);

        System.out.println("Question saved successfully!\n");
    }
}

class Quiz{
    ArrayList<Questions> questions;
    int score=0;
    public Quiz(ArrayList<Questions> questions){
        this.questions = questions;
    }
    Scanner sc=new Scanner(System.in);
    public void startQuiz(){
        if(questions.isEmpty()){
            System.out.println("No questions available");
            return;
        }

        System.out.println("\n====== QUIZ STARTED ======\n");

        int i=1;
        for (Questions q : questions) {

            System.out.println("Q" + i + ": " + q.question);
            System.out.println("A. " + q.A);
            System.out.println("B. " + q.B);
            System.out.println("C. " + q.C);
            System.out.println("D. " + q.D);

            System.out.print("Answer: ");
            char ans = sc.next().toUpperCase().charAt(0);

            if (ans == q.Answer) {
                score++;
            }

            System.out.println();
            i++;
        }
        showResult();
    }

    public void showResult() {
        int total = questions.size();

        System.out.println("===== RESULT =====");
        System.out.println("Total Questions: " + total);
        System.out.println("Correct: " + score);
        System.out.println("Wrong: " + (total - score));
        System.out.println("Score: " + score + "/" + total);

        double percent = (score * 100.0) / total;

        System.out.print("Performance: ");
        if (percent >= 80) System.out.println("Excellent");
        else if (percent >= 50) System.out.println("Good");
        else System.out.println("Need Improvement");
    }
}

public class Onlinequiz{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n===== ONLINE QUIZ SYSTEM =====");
            System.out.println("1. Admin - Add Question");
            System.out.println("2. User - Start Quiz");
            System.out.println("3. Exit");
            System.out.print("Enter choice: ");

            int choice = sc.nextInt();
            sc.nextLine();

            if (choice == 1) {
                Admin admin = new Admin();
                if(admin.login()){
                    admin.addQuestion();
                }else{
                    System.out.println("Access Denied.!");
                }

            } else if (choice == 2) {
                ArrayList<Questions> questions = FileManager.loadQuestions();
                Quiz quiz = new Quiz(questions);
                quiz.startQuiz();

            } else if (choice == 3) {
                System.out.println("Exiting...");
                break;
            } else {
                System.out.println("Invalid choice!");
            }
        }
        sc.close();
    }
}


// javac "Java - Online  ; java -cp "Java - Online Quiz" Onlinequiz