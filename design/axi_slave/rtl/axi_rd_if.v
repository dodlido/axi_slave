interface #(
    // Parameters // 
    parameter ID_R_WIDTH       =  4 , 
    parameter ADDR_WIDTH       =  8 ,
    parameter DATA_WIDTH       = 64 , 
    parameter USER_REQ_WIDTH   =  1 , 
    parameter USER_RESP_WIDTH  =  1 , 
    parameter ARSNOOP_WIDTH    =  1 , 
    parameter LOOP_R_WIDTH     =  1 ,
    parameter SECSID_WIDTH     =  1 , 
    parameter SID_WIDTH        =  1 , 
    parameter SSID_WIDTH       =  1 , 
    parameter SUBSYSID_WIDTH   =  1 , 
    parameter MPAM_WIDTH       =  1 , 
    parameter MECID_WIDTH      =  1 , 
    parameter RRESP_WIDTH      =  1 , 
    parameter RCHUNKNUM_WIDTH  =  1 , 
    parameter RCHUNKSTRB_WIDTH =  1 , 
) axi_rd_if (input ACLK, ARESETn);
    // Read request channel // 
    logic [                               0:0] ARVALID    ; // Valid indicator                              
    logic [                               0:0] ARREADY    ; // Ready indicator                              
    logic [ID_R_WIDTH                    -1:0] ARID       ; // Transaction identifier for the read channels 
    logic [ADDR_WIDTH                    -1:0] ARADDR     ; // Transaction address                          
    logic [                               3:0] ARREGION   ; // Region identifier
    logic [                               7:0] ARLEN      ; // Transaction length
    logic [                               2:0] ARSIZE     ; // Transaction size
    logic [                               1:0] ARBURST    ; // Burst attribute
    logic [                               0:0] ARLOCK     ; // Exclusive access indicator
    logic [                               3:0] ARCACHE    ; // Memory attributes
    logic [                               2:0] ARPROT     ; // Access attributes
    logic [                               0:0] ARNSE      ; // Non-secure extension bit for RME
    logic [                               3:0] ARQOS      ; // QoS identifier
    logic [USER_REQ_WIDTH                -1:0] ARUSER     ; // User-defined extension to a request
    logic [                               1:0] ARDOMAIN   ; // Shareability domain of a request
    logic [ARSNOOP_WIDTH                 -1:0] ARSNOOP    ; // Read request opcode
    logic [                               0:0] ARTRACE    ; // Trace signal
    logic [LOOP_R_WIDTH                  -1:0] ARLOOP     ; // Loopback signals on the read channels
    logic [                               0:0] ARMMUVALID ; // MMU signal qualifier
    logic [SECSID_WIDTH                  -1:0] ARMMUSECSID; // Secure Stream ID
    logic [SID_WIDTH                     -1:0] ARMMUSID   ; // StreamID
    logic [                               0:0] ARMMUSSIDV ; // SubstreamID valid
    logic [SSID_WIDTH                    -1:0] ARMMUSSID  ; // SubstreamID
    logic [                               0:0] ARMMUATST  ; // Address translated indicator
    logic [                               1:0] ARMMUFLOW  ; // SMMU flow type
    logic [                               3:0] ARPBHA     ; // Page-based HW attributes
    logic [                               3:0] ARNSAID    ; // Non=secure Access ID
    logic [SUBSYSID_WIDTH                -1:0] ARSUBSYSID ; // Subsystem ID 
    logic [MPAM_WIDTH                    -1:0] ARMPAM     ; // MPAM information with a request
    logic [                               0:0] ARCHUNKEN  ; // Read data chunking enable
    logic [                               0:0] ARIDUNQ    ; // Unique ID indicator
    logic [                               1:0] ARTAGOP    ; // Memory Tag operation for read requests
    logic [MECID_WIDTH                   -1:0] ARMECID    ; // Memory encryption context identifer
    // Read data channel //
    logic [                               0:0] RVALID     ; // Valid indicator 
    logic [                               0:0] RREADY     ; // Ready indicator 
    logic [ID_R_WIDTH                    -1:0] RID        ; // Transaction identifier for the read channels
    logic [                               0:0] RIDUNQ     ; // Unique ID indicator
    logic [DATA_WIDTH                    -1:0] RDATA      ; // Read data
    logic [$ceil(DATA_WIDTH/128)*4       -1:0] RTAG       ; // Memory tag
    logic [RRESP_WIDTH                   -1:0] RRESP      ; // Read response
    logic [                               0:0] RLAST      ; // Last read data
    logic [USER_REQ_WIDTH+USER_RESP_WIDTH-1:0] RUSER      ; // User-defined extension to read data and response
    logic [$ceil(DATA_WIDTH/64)          -1:0] RPOISON    ; // Poison indicator
    logic [                               0:0] RTRACE     ; // Trace signal 
    logic [LOOP_R_WIDTH                  -1:0] RLOOP      ; // Loopback signals in the read channels
    logic [                               0:0] RCHUNKV    ; // Read data chunking valid
    logic [RCHUNKNUM_WIDTH               -1:0] RCHUNKNUM  ; // Read data chunk number
    logic [RCHUNKSTRB_WIDTH              -1:0] RCHUNKSTRB ; // Read data chunk strobe
    logic [                               1:0] RBUSY      ; // Busy indicator
    // Manager Modport // 
    modport MNG (
    input ACLK, ARESETn, ARREADY, RVALID, RID, RIDUNQ, RDATA, RTAG, RRESP, RLAST, RUSER, RPOISON, RTRACE, RLOOP, RCHUNKV, RCHUNKNUM, RCHUNKSTRB, RBUSY,
    output RREADY, ARVALID, ARID, ARADDR, ARREGION, ARLEN, ARSIZE, ARBURST, ARLOCK, ARCACHE, ARPROT, ARNSE, ARQOS, ARUSER, ARDOMAIN, ARSNOOP, ARTRACE, ARLOOP, ARMMUVALID, ARMMUSECSID, ARMMUSID, ARMMUSSIDV, ARMMUSSID, ARMMUATST, ARMMUFLOW, ARPBHA, ARNSAID, ARSUBSYSID, ARMPAM, ARCHUNKEN, ARIDUNQ, ARTAGOP, ARMECID
    );
    // Subordinate Modport // 
    modport SUB (
    input ACLK, ARESETn, RREADY, ARVALID, ARID, ARADDR, ARREGION, ARLEN, ARSIZE, ARBURST, ARLOCK, ARCACHE, ARPROT, ARNSE, ARQOS, ARUSER, ARDOMAIN, ARSNOOP, ARTRACE, ARLOOP, ARMMUVALID, ARMMUSECSID, ARMMUSID, ARMMUSSIDV, ARMMUSSID, ARMMUATST, ARMMUFLOW, ARPBHA, ARNSAID, ARSUBSYSID, ARMPAM, ARCHUNKEN, ARIDUNQ, ARTAGOP, ARMECID,
    output ARREADY, RVALID, RID, RIDUNQ, RDATA, RTAG, RRESP, RLAST, RUSER, RPOISON, RTRACE, RLOOP, RCHUNKV, RCHUNKNUM, RCHUNKSTRB, RBUSY
    );
endinterface // axi_rd_if

//|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|//
//|                                               |//
//| 1. Project  :  axi_slave                      |//
//| 2. Author   :  Etay Sela                      |//
//| 3. Date     :  2024-12-28                     |//
//| 4. Version  :  v0.10.0                        |//
//|                                               |//
//|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|//
