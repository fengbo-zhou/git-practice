
import java.util.*;

public class (>>>FILE_SANS<<<)
{
    private final static int MOD = 1_000_000_007;

    public static long mod(long a, long b) {
        return ((a % b) + b ) % b;
    }

    public static int mod (int a, int b) {
        return ((a % b) + b ) % b;
    }
    
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
	(>>>1<<<)
	in.close();
    }
}
>>>TEMPLATE-DEFINITION-SECTION<<<
"Template defines 2 registers (message disappears with first user event):"
(?m "public static void main(String[] argv)")
(?p "System.out.println(")
