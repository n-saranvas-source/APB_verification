
module apb_testbench;
  
  dut_if dif();
  apb_slave dut(dif);
  
  initial begin
    dif.pclk = 0;
    dif.rst_n = 0;
    #10 dif.rst_n = 1;
  end
  
  always #5 dif.pclk = ~dif.pclk;


task automatic reset_test();
  // Apply reset
  $display("=== Starting Reset Test ===");
  //$display("=== Starting Reset Test ===");
  @(posedge dif.pclk); // Sync reset to clock edge
  dif.rst_n <= 0;
  repeat(2) @(posedge dif.pclk);
  dif.rst_n <= 1;
  @(posedge dif.pclk);

  // Check reset values
  assert(dif.psel == 0) else $fatal("Reset failed: psel not reset to 0");
  assert(dif.penable == 0) else $fatal("Reset failed: penable not reset to 0");
  assert(dif.pwrite == 0) else $fatal("Reset failed: pwrite not reset to 0");
  assert(dif.pready == 1) else $fatal("Reset failed: pready not reset to 1");
  assert(dif.prdata == 0) else $fatal("Reset failed: prdata not reset to 0");
  assert(dif.pwdata == 0) else $fatal("Reset failed: pwdata not reset to 0");

  $display("=== Reset Test Passed ===\n");
endtask  
  task automatic apb_write(input logic [31:0] addr, input logic [31:0] data);
    
    @(posedge dif.pclk);
    dif.psel <=1;
    dif.penable <= 0;
    dif.paddr <= addr;
    dif.pwdata <= data;
    dif.pwrite <= 1;
    @(posedge dif.pclk);
    dif.penable <= 1;  
    @(posedge dif.pclk);
    dif.psel <= 0;
    dif.penable <= 0;
  endtask
    
    
  task automatic apb_read(input logic[31:0] addr, output logic[31:0] data);
    @(posedge dif.pclk);
   	dif.psel <=1;
    dif.penable <= 0;
    dif.paddr <= addr;
    //dif.pwdata <= 0;
    dif.pwrite <= 0;
    @(posedge dif.pclk);
    dif.penable <= 1;
    @(posedge dif.pclk);
    dif.psel <= 0;
    dif.penable <= 0;
    wait (dif.pready);
    data = dif.prdata;
    
  endtask
  
  task automatic check_data_width(input logic [31:0] data);
    assert(data <= 32'hffffffff) else $fatal("Data width exceeds 32 bits");
  endtask
  
  task automatic test_setup_timing();
    $display("=== Testing Setup Phase Timing ===");
    
    // Test 1: Verify psel is asserted before penable
    @(posedge dif.pclk);
    dif.psel <= 1;
    dif.penable <= 0;
    dif.paddr <= 32'h10;
    dif.pwdata <= 32'h12345678;
    dif.pwrite <= 1;
    
    // Check that penable isn't asserted in the same cycle as psel
    @(posedge dif.pclk);
    assert(dif.penable == 0) else $fatal("Setup phase violation: penable asserted too early");
    
    // Complete the transfer
    dif.penable <= 1;
    @(posedge dif.pclk);
    dif.psel <= 0;
    dif.penable <= 0;
    
    $display("=== Setup Phase Timing Test Passed ===\n");
  endtask
  
  task automatic check_address(input logic [31:0]addr);
    assert(addr < 256) else $fatal("Address out of range");
  endtask
  
task automatic test_back_to_back_writes();
    $display("=== Testing Back-to-Back Writes ===");
    apb_write(32'h0f, 32'hB545A565);
    apb_write(32'hf0, 32'h55B5A5B5);
    apb_write(32'hf1, 32'hCCCCCCCC);
    $display("=== Back-to-Back Writes Completed ===");
endtask


task automatic test_back_to_back_reads(output logic[31:0] rd_data1, rd_data2, rd_data3);
    $display("=== Testing Back-to-Back Reads ===");
    
    
    // First read (full APB sequence)
    @(posedge dif.pclk);
    dif.psel <= 1;
    dif.penable <= 0;
    dif.paddr <= 32'h0f;
    dif.pwrite <= 0;
    
    // Second read begins immediately
    @(posedge dif.pclk);
    dif.penable <= 1; 
    wait (dif.pready);
    // First read's access phase
    rd_data1 = dif.prdata; // Capture first read data
    
    @(posedge dif.pclk);
    dif.psel <= 1;     // Maintain select
    dif.penable <= 0;  // Setup phase for second read
    dif.paddr <= 32'hf0;
     dif.pwrite <= 0;
    // Third read pipeline
    @(posedge dif.pclk);
    dif.penable <= 1;  // Second read's access phase
    wait (dif.pready);
    rd_data2 = dif.prdata; // Capture second read data

    @(posedge dif.pclk);
    dif.psel <= 1;     // Maintain select
    dif.penable <= 0;  // Setup phase for third read
    dif.paddr <= 32'hf1;
    dif.pwrite <= 0;
    
    // Cleanup and final read capture
    @(posedge dif.pclk);
    dif.penable <= 1;  // Third read's access phase
    wait (dif.pready);
    rd_data3 = dif.prdata;
    
    dif.psel <= 0;
    dif.penable <= 0;
    
    // Verification
  // apb_read(32'h0f, rd_data1);
    //apb_read(32'hf0, rd_data2);
    //apb_read(32'hf1, rd_data3);

    $display("Read Data 1: %h", rd_data1);
    $display("Read Data 2: %h", rd_data2);
    $display("Read Data 3: %h", rd_data3);

    if (rd_data1 !== 32'hB545A565) $error("Read1 mismatch: Exp: AAAAAAAA Got: %h", rd_data1);
    if (rd_data2 !== 32'h55B5A5B5) $error("Read2 mismatch: Exp: BBBBBBBB Got: %h", rd_data2);
    if (rd_data3 !== 32'hCCCCCCCC) $error("Read3 mismatch: Exp: CCCCCCCC Got: %h", rd_data3);
    
    $display("=== Back-to-Back Reads Completed ===");
endtask

task automatic back_to_back_combined(output logic[31:0] rd_data1, rd_data2, rd_data3);

	test_back_to_back_writes();
	test_back_to_back_reads( rd_data1, rd_data2, rd_data3);





endtask



     
  initial begin
    logic[31:0] read_data, rd_data1, rd_data2, rd_data3;
    
    reset_test();
    


    apb_write(32'hff, 32'hA5A5A5A5);
    apb_read(32'hff, read_data);
    //test_back_to_back_writes();
    //test_back_to_back_reads(rd_data1, rd_data2, rd_data3);
    back_to_back_combined(rd_data1, rd_data2, rd_data3);
    check_data_width(read_data);
    test_setup_timing();
    check_address(32'hff);
   // test_back_to_back_transfers();
    Invalid_Address_Test();
    
    $display("read Data: %h", read_data);
    $finish;
  end
endmodule
    
    
    
    
    
