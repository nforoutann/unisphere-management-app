package network;

import java.net.ServerSocket;

public class Server {
    public static void main(String[] args) throws Exception {
        System.out.println("Welcome to the server!");
        ServerSocket serverSocket = new ServerSocket(8080);
        while (true) {
            System.out.println("Waiting for client...");
            new RequestHandler(serverSocket.accept()).start();
        }
    }
}