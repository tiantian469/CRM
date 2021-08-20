package ghostcat;

public class test01 {
    public static void main(String[] args) {
        String[] a = new String[2];
        Object[] b = a;
        //a[0] = "hi";
        //b[1] = String.valueOf(42);
        b[0] = Integer.valueOf(42);
        System.out.println(b[0]);
        System.out.println(b[1]);
    }
}
