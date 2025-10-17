// Code your design here
interface dut_if;
  
  logic pclk;
  logic rst_n;
  logic [31:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic pready;
  logic [31:0] prdata;
  
  clocking master_cb @(posedge pclk);
    output paddr,psel, penable, pwrite, pwdata;
    input prdata;
  endclocking: master_cb
  
  clocking slave_cb @(posedge pclk);
    input paddr,psel, penable, pwrite, pwdata;
    output prdata;
  endclocking: slave_cb
  
  clocking monitor_cb@(posedge pclk);
    input paddr,psel,penable, pwrite, prdata,pwdata;
  endclocking: monitor_cb
  
  
  modport master(clocking master_cb);
    modport slave(clocking slave_cb);
      modport passive(clocking monitor_cb);
        
endinterface
        
        
    
  


module apb_slave(dut_if dif);
  
  logic [31:0] mem[0:256];
  logic [1:0] apb_st;
  const logic [1:0] SETUP =0;
  const logic [1:0] W_ENABLE = 1;
  const logic [1:0] R_ENABLE =2;
  
  always @(posedge dif.pclk or negedge dif.rst_n) begin
    if (dif.rst_n == 0) begin
      apb_st <= 0;
      dif.penable <= 0;
      dif.prdata <= 0;
      dif.pwdata <= 0;
      dif.pready <= 1;
      dif.pwrite <=0;
      dif.psel <= 0;
      for(int i=0;i<256; i++) 
        mem[i] = i;
    end
    
    else begin
      case (apb_st)
        // Setup Phase
        SETUP: begin
          dif.pready <= 0; // Not ready yet
          if (dif.psel && !dif.penable) begin
            apb_st <= dif.pwrite ? W_ENABLE : R_ENABLE;
          end
        end

        // Write Enable Phase
        W_ENABLE: begin
          if (dif.psel && dif.penable && dif.pwrite) begin
            mem[dif.paddr] <= dif.pwdata; // Write data to memory
            dif.pready <= 1; // Ready signal goes high to complete transfer
            apb_st <= SETUP; // Return to SETUP for next transaction
          end
        end

        // Read Enable Phase
        R_ENABLE: begin
          if (dif.psel && dif.penable && !dif.pwrite) begin
            dif.prdata <= mem[dif.paddr]; // Read data from memory
            dif.pready <= 1; // Ready signal goes high
            apb_st <= SETUP; // Return to SETUP
          end
        end

        default: apb_st <= SETUP; // Safety default state
      endcase
    end
  end
endmodule
