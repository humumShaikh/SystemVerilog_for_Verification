class Packet;
  
  rand bit [ 5 :  0] length;
  rand bit [ 5 :  0] address;
  integer n = 0;
  
  constraint addr {
    address inside {[0 : 63-length]};
  };
  
  Frame totalFrames[$];
  
  function new();
    n = 0;
    repeat(length)
    begin
      Frame f;
      f = new();
      f.randomize();
      f.data = {address+n};  //6 bit address * 5 which is < 32 bits // giving address as data
      
      
      totalFrames.push_back(f);
      
      $display("Pushing frame %d to packet" , n);
      $display("Frame Details : Data = Address = %0h" , address);
      
      n = n + 1;
    end
  endfunction
  
  
  function void display(string msg);
    $display("%s" , msg);
  endfunction
  
endclass