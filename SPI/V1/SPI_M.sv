`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// Create Date: 23.12.2025 22:16:22
// Design Name: SPI 
// Module Name: SPI_M
// Target Devices: xc7a35tcpg236-1 (Basys3)
// Description: SPI Master Module - 8 bit
// Revision: V1
// Revision 0.01 - File Created
// Additional Comments: SPI Mode 1 : CPOL = 0 CPHA = 1 , Tx +posedge Rx -negedge
//////////////////////////////////////////////////////////////////////////////////


module SPI_M
(
    input wire [7:0] din,                //if you want to set the internal register data from outside
    input wire  start,                   //start trigger to initiate the communication, do set it low on the next posedge
    input wire  clk,
    input wire  reset,
    input wire  miso,
    output reg  mosi,
    output wire sclk,
    output reg  ss,
    output wire [7:0] dout
);
    
    reg start_flag = 0;
    reg sclk_flag = 0;
    reg [3:0] counter = 8;
    reg dataBuffer = 0;
    reg [7:0] masterData = 8'h21; //0 1        //default data if you comment the line below 'masterData <= din'
    
    
    initial
    begin
        mosi <= 1'b0;
        ss <= 1'b1;
    end

    
    always @(posedge clk)
    begin //-//-//
        if(reset == 1'b1)
        begin //-//
            ss <= 1'b1;
            mosi <= 1'b0;
            masterData <= 8'hA3;
            start_flag <= 1'b0;
            sclk_flag <= 1'b0;
        end //-//
        
        else if(start == 1'b1    &&    start_flag ==1'b0)
        begin //-//
            start_flag <= 1'b1;
            ss <= 1'b0;
            masterData <= din;        //Comment this line if you want to set the to be transmitted data fixed at start
        end //-//
        
        else if(start_flag == 1'b1)
        begin //-//
            if(counter == 8)
            begin
                sclk_flag <= 1'b1;
                mosi <= masterData[7];
                masterData <= masterData << 1;
                counter <= counter - 1'b1;
            end
            
            else if(counter > 1)
            begin //
                sclk_flag <= 1'b1;
                mosi <= masterData[7];
                masterData <= masterData << 1;
                masterData[1] <= dataBuffer;
                counter <= counter - 1'b1;
            end //
            
            else if(counter == 1)
            begin //
                mosi <= masterData[7];
                masterData <= masterData << 1;
                masterData[1] <= dataBuffer;
                counter <= counter - 1'b1;
            end //
            
            else if(counter == 0)
            begin //
                masterData[0] <= dataBuffer;
                sclk_flag <= 1'b0;
                mosi <= 1'b0;
                ss <= 1'b1;
                start_flag <= 1'b0;
                counter <= 8;
            end //
        end //-//
        
    end //-//-//
    
    
    
    always @(negedge sclk)
    begin
        if(sclk_flag == 1'b1)
        begin
            dataBuffer <= miso;
        end
    end
    
    
    assign sclk = (sclk_flag) ? clk : 1'b0;
    
    assign dout = masterData;

endmodule
