package com.toad.jmeter.util.elc;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class asdasd {
  public void abd(){
      List<String> keys = Arrays.asList("USERNAME","AUTH_CODE","DCMTYPE");
      List<String> values = new ArrayList<>();
      for (String key : keys) {
          String value = vars.get("USERNAME");
          if (null == value ){
              value = "-";
          }
          values.add(value);
      }

      String outStrin = values.stream().map(String::valueOf).collect(Collectors.joining(","));

      for (String key : keys ) {

      }
      String fileNmae = "/Users/toad/Desktop/out/bbc.csv";
      try {
          FileWriter fstream = new FileWriter(fileNmae,true);
          BufferedWriter out = new BufferedWriter(fstream);
          out.write("asdasd" + "\n");
          out.close();
          fstream.close();
      } catch (IOException e) {
          e.printStackTrace();
      }
  }
}
