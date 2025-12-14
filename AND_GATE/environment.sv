//Environment class which will contain all the subclasses and connect all them together

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class Environment;

  Generator gen;    //handle of class Generator
  Driver drv;       //handle of class Driver
  Monitor mon;      //handle of class Monitor
  Scoreboard scb;   //handle of class Scoreboard
  
  mailbox gen2drv;    //mailbox for sending and receiving data between Generator and Driver
  mailbox mon2scb;    //mailbox for sending and receiving data between Monitor and Scoreboard
  
  virtual intf vif;   //virtual instance of interface
  
  
  function new(virtual intf vif);   //constructor of class Environment
    this.vif = vif;   //connect the virutal interface passed in the arguement to the locally created virutal interface
    
    gen2drv = new();    //creating a mailbox 
    mon2scb = new();    //creating a mailbox
    
    gen = new(gen2drv);              //creating an object of class Generator
    drv = new(vif , gen2drv);        //creating an object of class Driver
    mon = new(vif , mon2scb);        //creating an object of class Monitor
    scb = new(mon2scb);             //creating an object of class Scoreboard
    
  endfunction
  
  
  task run_test();      //main task or responsibility of class Environment
    fork                //fork join to run all these tasks together
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join
  endtask

endclass