`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// 
// Create Date: 24.12.2025 23:33:51
// Design Name: 
// Module Name: SPI_S
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: SPI Mode 1 : CPOL = 0 CPHA = 1 , Tx +posedge Rx -negedge
// 
//////////////////////////////////////////////////////////////////////////////////


module SPI_S
(
    input wire sclk,
    input wire mosi,
    input wire ss,
    output reg miso
);

    reg start_flag = 0;
    reg dataBuffer = 0;
    reg [3:0] counter = 8;
    reg [7:0] slaveData = 8'hAF; //
  
    
    
    always @(posedge sclk)
    begin
        if(ss == 1'b0)
        begin
            if(counter == 8)
            begin
                miso <= slaveData[7];
                slaveData <= slaveData << 1;
                counter <= counter - 1;
            end
            
            else if(counter > 0)
            begin
                miso <= slaveData[7];
                slaveData <= slaveData << 1;
                slaveData[1] <= dataBuffer;
                counter <= counter - 1;
            end
            
            else if(counter == 0) 
            begin
                slaveData[0] <= dataBuffer;
                counter <= 8;
            end
        end
    end
    
    
    always @(negedge sclk)
    begin
        if(ss == 1'b0)
        begin
            dataBuffer <= mosi;
        end
    end

endmodule