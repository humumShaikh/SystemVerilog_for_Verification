class Transaction;

  rand bit A;
  rand bit B;
  rand bit [1:0] S;
       bit Y;
       
 
  function void display(string msg);
    string mode = "";
    case (S)
      0 : mode = "XOR";
      1 : mode = "AND";
      2 : mode = "ADD";
      3 : mode = "SUB";
    endcase
    $display("__________%s__________" , msg);
    $display("A = %0b B = %0b S = %s" , A,B,mode);
  endfunction      

endclass