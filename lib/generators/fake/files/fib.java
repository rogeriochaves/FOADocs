class Fibonacci {

	public static void main(String[] args) {
		System.out.println(fib(36));
	}

	public static int fib(int n){
		return n < 2 ? n : fib(n-1) + fib(n-2);
	}

}