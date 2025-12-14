//Finally the top testbench file
//The testbench is supposed to have the static stuff i.e. the DUT , the interface
//Also it will have the test

module testbench();

  intf itfc();     //creating a a static hard instance of the interface

  test tst(itfc);    //creating an instance of program test and connecting the interface with it
  
  AND_GATE AG(      //calling the instance of the DUT (design file)
    .A(itfc.A),       //connecting the ports of the DUT with the interface
    .B(itfc.B),
    .Y(itfc.Y)  
  );
  
  
  initial           //let the simulation run once
  begin 
    #500;           //for 500ns
    $finish;
  end

endmodule