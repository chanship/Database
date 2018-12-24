package epitrochoid;

import java.io.*;
import java.math.*;

public class epitrochoid {
	static double x(double a, double b, double c, double t){
		return (a+b) * Math.cos(t) - c * Math.cos((a/b+1)*t);
	}
	static double y(double a, double b, double c, double t){
		return (a+b) * Math.sin(t) - c * Math.sin((a/b+1)*t);
	}
	public static void main(String[] args) {
		// OHE 122
		double coordX = 34.020967;
		double coordY = -118.289415;
		double a = 0.0005;
		double b = 0.0003;
		double c = 0.0005;
		double t = 0.0;

		for(t=0.0; t<=6*Math.PI; t+=0.01){
			System.out.print(coordY + y(a,b,c,t) + ",");
			System.out.println(coordX + x(a,b,c,t));
		}
	}
}