package controller;

import java.util.HashMap;
import java.util.Map;

public class test {
	public static void main(String[] args) {
		
		Map<String,Object> temp = new HashMap<String,Object>();
		temp.put("1", "1");
		System.out.println(temp.get("1"));
		System.out.println(temp.get("2"));
	}
}
