import java.io.*;

public class miso {
    public static void main( String[] args ) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("文字を入力せよ");
        String s = br.readLine();    // 1行分の文字列を入力する
        System.out.println(s + "だおーー");

        System.out.println("数字を入力せよ");
        int i = Integer.parseInt(br.readLine());    // 1行分の文字列を入力する
        System.out.println(i + "だおーー");
    }
}
