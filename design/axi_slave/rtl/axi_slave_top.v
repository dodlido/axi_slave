module axi_slave_top #(
    parameter DATA_WIDTH = 64 , 
    parameter ADDR_WIDTH =  8 , 
) (
    // General signals // 
    input wire [0:0]            clk       , // Clock signal 
    input wire [0:0]            rst_n     , // Async reset, active low
    // AXI read interface // 
    axi_rd_if                   axi_rd_if , // AXI read interface
    // Simple slave interface // 
    input wire [DATA_WIDTH-1:0] dat_rd    , // Read data
    output reg [ADDR_WIDTH-1:0] add_rd    , // Read address 
    output reg [           0:0] oen       , // Output enable
    output reg [           0:0] wen       , // Write enable 
    output reg [ADDR_WIDTH-1:0] add_wr    , // Write sddress 
    output reg [DATA_WIDTH-1:0] dat_wr    , // Write data
);

endmodule

//|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|//
//|                                               |//
//| 1. Project  :  axi_slave                      |//
//| 2. Author   :  Etay Sela                      |//
//| 3. Date     :  2024-12-28                     |//
//| 4. Version  :  v0.10.0                        |//
//|                                               |//
//|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|//
