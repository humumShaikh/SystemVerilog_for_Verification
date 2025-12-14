//The program test (is not a class or class object)
//The program test is made so that we can have multiple environments in it, here we only have one so it might seem redundant

`include "environment.sv"

program test(intf vif);   //program with interface as an arguement

  Environment env;        //creating a handle of the class environment
  
  initial                   //to run it once
  begin       
    env = new(vif);         //alloting memory to the environment handle and passing virtual interface as arguement
    env.run_test();         //calling the main task of the environment class
  end

endprogram