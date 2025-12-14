//Transaction Class for creating an object of a transaction
//Will only be alive for the duration of the transaction and then deleted hence it is a class

class Transaction;
  
  rand bit A; //randomizing A since we want to test it by giving random inputs
  rand bit B; //randomizing B since we want to test it by giving random inputs
       bit Y; //Not randomizing Y since it is an output and not an input and common sense wise it is not supposed to be driven
  //note that the rand keyword will randomly allot the value to the bit when the randomize() function will be called
  
  function void display(string msg);  //simple function to display anything if needed (optional)
    $display("-------%s------" , msg);
    $display("A = %0b B = %0b" , A , B);
    $display("...............");
  endfunction     
       
  
endclass