module alu_tb;

    reg [31:0] A, B;
    reg [4:0] ALUControl;
    
  
    wire [31:0] Result;
    wire Zero, Carry, Overflow, Negative;


    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Zero(Zero),
        .Carry(Carry),
        .Overflow(Overflow),
        .Negative(Negative)
    );



task automatic run_ADDU_test;
       input logic [31:0] a,b;
       input logic [4:0]ctrl;
       
       logic [31:0] Expected_Result;
       
       logic Expected_Carry, Expected_Overflow;
begin
    // Input Values
    A = a; 
    B = b; 
    ALUControl = 5'b00101; // ADDU opcode

    // Expected Values Calculation
    Expected_Result = A + B; // Unsigned addition formula
    Expected_Carry = (A + B) > 32'hFFFF_FFFF ? 1 : 0; // Carry flag formula
    Expected_Overflow = 0; // Overflow flag is not set in unsigned addition

    // Apply Inputs
    #10;
    
    // Assertions to verify correctness
    assert (Result == Expected_Result) 
        else $error("ADDU Failed: Expected %h, Got %h", Expected_Result, Result);
    assert (Carry == Expected_Carry) 
        else $error("Carry Flag Mismatch: Expected %b, Got %b", Expected_Carry, Carry);
    assert (Overflow == Expected_Overflow) 
        else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);

    $display("ADDU Test Passed: A = %h, B = %h, Result = %h, Carry = %b, Overflow = %b", 
              A, B, Result, Carry, Overflow);
    end
endtask

task automatic run_ADDS_test;
     input logic [31:0] a,b;
     input logic [4:0]ctrl;
      
        logic [31:0] Expected_Result;
        logic Expected_Carry, Expected_Overflow,expected_negative,expected_zero;
    begin
        
        A=a;
	B=b;
	ALUControl = ctrl;
        // Expected Values Calculation
        Expected_Result = $signed(A) + $signed(B); // Signed addition formula
        Expected_Carry = (Expected_Result > 32'hFFFF_FFFF) ? 1 : 0; // Carry flag formula (irrelevant for signed addition)
        Expected_Overflow = (A[31] == B[31]) && (Expected_Result[31] != A[31]); // Overflow condition
        expected_zero = (Expected_Result == 32'b0);
        expected_negative = Expected_Result[31];
        // Wait for ALU to compute
        #10;
        
        // Assertions to verify correctness
        
        assert (Result == Expected_Result) 
            else $error("ADDS Failed: Expected %h, Got %h", Expected_Result, Result);

        assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

        assert (Carry == Expected_Carry) 
            else $error("Carry Flag Mismatch: Expected %b, Got %b", Expected_Carry, Carry);
        assert (Overflow == Expected_Overflow) 
            else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);
        assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);


        $display("ADDS Test Passed: A = %h, B = %h, Result = %h, Carry = %b, Overflow = %b", 
                  A, B, Result, Carry, Overflow);
    end
    endtask

task automatic SUBU_test;
input [31:0] a, b;
input [4:0] ctrl;
logic expected_zero;
logic [31:0] expected_result;
logic expected_carry, expected_overflow;
logic expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;

expected_result = A-B;
expected_carry=(A < B) ? 1 : 0;
expected_overflow=0;
expected_zero = (expected_result == 32'b0)?1:0;

expected_negative = expected_result[31];
#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask

task automatic SUBS_test;
input [31:0] a, b;
input [4:0] ctrl;
logic expected_zero;
logic [31:0] expected_result;
logic expected_carry, expected_overflow;
logic expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;

expected_result = A-B;
expected_carry=(A < B) ? 1 : 0;
expected_overflow=(A[31] != B[31]) && (expected_result[31] != A[31]);
expected_zero = (expected_result == 0)?1:0;
expected_negative= expected_result[31];
#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


task automatic MULTU_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [63:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;
expected_carry=expected_result[32];
expected_result = A*B;
expected_zero = (expected_result == 0)?1:0;
expected_negative= expected_result[31];
expected_overflow = (expected_result[32]!=0);


#10;
assert (Result === expected_result[31:0])
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


task automatic MULTS_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [63:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;

expected_result = $signed(A)*$signed(B);
expected_zero = (expected_result == 0)?1:0;
expected_negative= expected_result[31];
expected_overflow = (expected_result[63:32]!=0);
expected_carry = expected_result[32];



#10;
assert (Result === expected_result[31:0])
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


task automatic AND_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [31:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;

expected_result = A&B;
expected_zero = (expected_result == 32'b0);
expected_carry = 1'b0;
expected_overflow = 1'b0;
expected_negative = expected_result[31];


#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask

task automatic OR_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [31:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;
expected_result = A|B;
expected_zero = (expected_result == 32'b0);
expected_carry = 1'b0;
expected_overflow = 1'b0;
expected_negative = expected_result[31];


#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


task automatic NAND_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [31:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;
expected_result = ~(A&B);
expected_zero = (expected_result == 32'b0);
expected_carry = 1'b0;
expected_overflow = 1'b0;
expected_negative = expected_result[31];

#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask



task automatic XOR_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [31:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;
expected_result = A^B;
expected_zero = (expected_result == 32'b0);
expected_carry = 1'b0;
expected_overflow = 1'b0;
expected_negative = expected_result[31];

#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


task automatic NOT_test;
input [31:0] a, b;
input [4:0] ctrl;
logic [31:0] expected_result;
logic expected_zero, expected_carry, expected_overflow, expected_negative;

begin

A=a;
B=b;
ALUControl = ctrl;
expected_result = ~(A);
expected_zero = (expected_result == 32'b0);
expected_carry = 1'b0;
expected_overflow = 1'b0;
expected_negative = expected_result[31];

#10;
assert (Result === expected_result)
                $display("PASS: Result Correct - %h", Result);
            else
                $error("FAIL: Result Mismatch! Expected: %h, Got: %h", expected_result, Result);

            assert (Zero === expected_zero)
                $display("PASS: Zero Flag Correct - %b", Zero);
            else
                $error("FAIL: Zero Flag Mismatch! Expected: %b, Got: %b", expected_zero, Zero);

            assert (Carry === expected_carry)
                $display("PASS: Carry Flag Correct - %b", Carry);
            else
                $error("FAIL: Carry Flag Mismatch! Expected: %b, Got: %b", expected_carry, Carry);

            assert (Overflow === expected_overflow)
                $display("PASS: Overflow Flag Correct - %b", Overflow);
            else
                $error("FAIL: Overflow Flag Mismatch! Expected: %b, Got: %b", expected_overflow, Overflow);

            assert (Negative === expected_negative)
                $display("PASS: Negative Flag Correct - %b", Negative);
            else
                $error("FAIL: Negative Flag Mismatch! Expected: %b, Got: %b", expected_negative, Negative);
        end


endtask


 task automatic SLT_test(
        input logic [31:0] test_A,
        input logic [31:0] test_B,
        input logic [4:0] test_ALUControl
       
    );
 logic [31:0] expected_Result;
        logic expected_Carry;

        logic expected_Overflow;

        begin
            A = test_A;
            B = test_B;
            ALUControl = test_ALUControl;
	    expected_Result=(A < B) ? 32'b1 : 32'b0;
            expected_Overflow =1'b0;
            expected_Carry = 1'b0;

            #10; 
            
            // Assertions
            assert (Result === expected_Result) 
                else $error("Test Failed: Expected Result %h, got %h", expected_Result, Result);
            assert (Carry === expected_Carry) 
                else $error("Test Failed: Expected Carry %b, got %b", expected_Carry, Carry);
            assert (Overflow === expected_Overflow) 
                else $error("Test Failed: Expected Overflow %b, got %b", expected_Overflow, Overflow);
            
            $display("Test Passed: ALUControl=%b, A=%h, B=%h, Result=%h", test_ALUControl, test_A, test_B, Result);
        end
endtask


task automatic SEQ_test(
        input logic [31:0] test_A,
        input logic [31:0] test_B,
        input logic [4:0] test_ALUControl
       
    );
 	logic [31:0] expected_Result;
        logic expected_Carry;

        logic expected_Overflow;

        begin
            A = test_A;
            B = test_B;
            ALUControl = test_ALUControl;
	    expected_Result=(A == B) ? 32'b1 : 32'b0;
            expected_Overflow =1'b0;
            expected_Carry = 1'b0;

            #10; 
            
            // Assertions
            assert (Result === expected_Result) 
                else $error("Test Failed: Expected Result %h, got %h", expected_Result, Result);
            assert (Carry === expected_Carry) 
                else $error("Test Failed: Expected Carry %b, got %b", expected_Carry, Carry);
            assert (Overflow === expected_Overflow) 
		else $error("Test Failed: Expected Overflow %b, got %b", expected_Overflow, Overflow);
            
            $display("Test Passed: ALUControl=%b, A=%h, B=%h, Result=%h", test_ALUControl, test_A, test_B, Result);
        end
endtask

task automatic SNEQ_test(
        input logic [31:0] test_A,
        input logic [31:0] test_B,
        input logic [4:0] test_ALUControl
       
    );
 	logic [31:0] expected_Result;
        logic expected_Carry;

        logic expected_Overflow;

        begin
            A = test_A;
            B = test_B;
            ALUControl = test_ALUControl;
	    expected_Result=(A != B) ? 32'b1 : 32'b0;
            expected_Overflow =1'b0;
            expected_Carry = 1'b0;

            #10; 
            
            // Assertions
            assert (Result === expected_Result) 
                else $error("Test Failed: Expected Result %h, got %h", expected_Result, Result);
            assert (Carry === expected_Carry) 
                else $error("Test Failed: Expected Carry %b, got %b", expected_Carry, Carry);
            assert (Overflow === expected_Overflow) 
		else $error("Test Failed: Expected Overflow %b, got %b", expected_Overflow, Overflow);
            
            $display("Test Passed: ALUControl=%b, A=%h, B=%h, Result=%h", test_ALUControl, test_A, test_B, Result);
        end
endtask 

task automatic SLE_test(
        input logic [31:0] test_A,
        input logic [31:0] test_B,
        input logic [4:0] test_ALUControl
       
    );
 	logic [31:0] expected_Result;
        logic expected_Carry;

        logic expected_Overflow;

        begin
            A = test_A;
            B = test_B;
            ALUControl = test_ALUControl;
	    expected_Result=(A <= B) ? 32'b1 : 32'b0;
            expected_Overflow =1'b0;
            expected_Carry = 1'b0;

            #10; 
            
            // Assertions
            assert (Result === expected_Result) 
                else $error("Test Failed: Expected Result %h, got %h", expected_Result, Result);
            assert (Carry === expected_Carry) 
                else $error("Test Failed: Expected Carry %b, got %b", expected_Carry, Carry);
            assert (Overflow === expected_Overflow) 
		else $error("Test Failed: Expected Overflow %b, got %b", expected_Overflow, Overflow);
            
            $display("Test Passed: ALUControl=%b, A=%h, B=%h, Result=%h", test_ALUControl, test_A, test_B, Result);
        end
endtask  


task automatic SGE_test(
        input logic [31:0] test_A,
        input logic [31:0] test_B,
        input logic [4:0] test_ALUControl
       
    );
 	logic [31:0] expected_Result;
        logic expected_Carry;

        logic expected_Overflow;

        begin
            A = test_A;
            B = test_B;
            ALUControl = test_ALUControl;
	    expected_Result=(A >= B) ? 32'b1 : 32'b0;
            expected_Overflow =1'b0;
            expected_Carry = 1'b0;

            #10; 
            
            // Assertions
            assert (Result === expected_Result) 
                else $error("Test Failed: Expected Result %h, got %h", expected_Result, Result);
            assert (Carry === expected_Carry) 
                else $error("Test Failed: Expected Carry %b, got %b", expected_Carry, Carry);
            assert (Overflow === expected_Overflow) 
		else $error("Test Failed: Expected Overflow %b, got %b", expected_Overflow, Overflow);
            
            $display("Test Passed: ALUControl=%b, A=%h, B=%h, Result=%h", test_ALUControl, test_A, test_B, Result);
        end
endtask             

task automatic test_case_SEQZ(
	input logic [31:0] test_A, 
	 
    	input logic [4:0] test_ALUControl
        
);
        logic [31:0] Expected_Result;
	logic Expected_Zero;
        logic Expected_Overflow;

	begin

            A = test_A;
            //B = test_B;
            ALUControl = test_ALUControl;
	   Expected_Result = (A == 0) ? 32'b1 : 32'b0;
           Expected_Zero = 1'b0;
           Expected_Overflow = 1'b0;
	 #10;
    
    // Assertions to verify correctness
    assert (Result == Expected_Result) 
        else $error("SEQZ Failed: Expected %h, Got %h", Expected_Result, Result);
    assert (Zero == Expected_Zero) 
        else $error("Zero Flag Mismatch: Expected %b, Got %b", Expected_Zero, Zero);
    assert (Overflow == Expected_Overflow) 
        else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);

    $display("SEQZ Test Passed: A = %h, Result = %h, Zero = %b", A, Result, Zero);
	end
endtask

task automatic test_case_SNEZ(
	input logic [31:0] test_A, 
	 
    	input logic [4:0] test_ALUControl
        
);
        logic [31:0] Expected_Result;
	logic Expected_Zero;
        logic Expected_Overflow;

	begin

            A = test_A;
            //B = test_B;
            ALUControl = test_ALUControl;
	   Expected_Result = (A != 0) ? 32'b1 : 32'b0;
           Expected_Zero = 1'b0;
           Expected_Overflow = 1'b0;
	 #10;
    
    // Assertions to verify correctness
    assert (Result == Expected_Result) 
        else $error("SEQZ Failed: Expected %h, Got %h", Expected_Result, Result);
    assert (Zero == Expected_Zero) 
        else $error("Zero Flag Mismatch: Expected %b, Got %b", Expected_Zero, Zero);
    assert (Overflow == Expected_Overflow) 
        else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);

    $display("SEQZ Test Passed: A = %h, Result = %h, Zero = %b", A, Result, Zero);
	end
endtask


task automatic test_case_SNEG(
	input logic [31:0] test_A, 
	 
    	input logic [4:0] test_ALUControl
        
);
        logic [31:0] Expected_Result;
	logic Expected_Zero;
        logic Expected_Overflow;

	begin

            A = test_A;
            //B = test_B;
            ALUControl = test_ALUControl;
	   Expected_Result = (A[31] == 1) ? 32'b1 : 32'b0;
           Expected_Zero = 1'b0;
           Expected_Overflow = 1'b0;
	 #10;
    
    // Assertions to verify correctness
    assert (Result == Expected_Result) 
        else $error("SEQZ Failed: Expected %h, Got %h", Expected_Result, Result);
    assert (Zero == Expected_Zero) 
        else $error("Zero Flag Mismatch: Expected %b, Got %b", Expected_Zero, Zero);
    assert (Overflow == Expected_Overflow) 
        else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);

    $display("SEQZ Test Passed: A = %h, Result = %h, Zero = %b", A, Result, Zero);
	end
endtask

task automatic test_case_SPOS(
	input logic [31:0] test_A, 
	 
    	input logic [4:0] test_ALUControl
        
);
        logic [31:0] Expected_Result;
	logic Expected_Zero;
        logic Expected_Overflow;

	begin

            A = test_A;
            //B = test_B;
            ALUControl = test_ALUControl;
	   Expected_Result = (A[31] == 0) ? 32'b1 : 32'b0;
           Expected_Zero = 1'b0;
           Expected_Overflow = 1'b0;
	 #10;
    
    // Assertions to verify correctness
    assert (Result == Expected_Result) 
        else $error("SEQZ Failed: Expected %h, Got %h", Expected_Result, Result);
    assert (Zero == Expected_Zero) 
        else $error("Zero Flag Mismatch: Expected %b, Got %b", Expected_Zero, Zero);
    assert (Overflow == Expected_Overflow) 
        else $error("Overflow Flag Mismatch: Expected %b, Got %b", Expected_Overflow, Overflow);

    $display("SEQZ Test Passed: A = %h, Result = %h, Zero = %b", A, Result, Zero);
	end
endtask




initial begin
      
        run_ADDU_test(
	32'h0000_0003,
	32'h0000_0002,
	5'b00101);



//################################################################################################################################


//signed addition
        run_ADDS_test(
        32'h7FFF_FFFF,
	32'h0000_0001,
 	5'b00110);
//run_ADDS_test(32'h7FFF_FFFF, 32'h0000_0001); // INT_MAX + 1 -> Overflow
        run_ADDS_test(32'h8000_0000, 32'hFFFF_FFFF, 5'b00110); // INT_MIN - 1 -> No overflow
        run_ADDS_test(32'h8000_0000, 32'h8000_0000, 5'b00110); // INT_MIN + INT_MIN -> Overflow
        run_ADDS_test(32'h7FFF_FFFF, 32'h7FFF_FFFF, 5'b00110); // INT_MAX + INT_MAX -> Overflow
        run_ADDS_test(32'h0000_0000, 32'h0000_0000, 5'b00110); // Zero + Zero

        // Random test cases
        run_ADDS_test($random, $random, 5'b00110);
        run_ADDS_test($random, $random, 5'b00110);
 

//################################################################################################################################



 SUBU_test(
            32'h0000_000A, // A
            32'h0000_0009, // B
            5'b00111    // ALUControl for ADDU  
	);



//################################################################################################################################


SUBS_test(32'h8000_0000, // A
          32'h0000_0001, // B
          5'b01000      // ALUControl for ADDU
);
//carry overflow
        SUBS_test(32'h7FFFFFFF, -1,5'b01000 );               // MAX - (-1) = MIN (overflow)
        SUBS_test(32'h80000000, 1, 5'b01000);                // MIN - 1 = MAX (overflow)
        SUBS_test(0, 32'h7FFFFFFF, 5'b01000);                // 0 - MAX = -MAX
        SUBS_test(32'h80000000, 32'h7FFFFFFF, 5'b01000);          // MIN - MAX = ? (overflow)
//edge cases
        SUBS_test(0, 0, 5'b01000);                      // 0 - 0 = 0
        SUBS_test(32'h7FFFFFFF, 32'h7FFFFFFF, 5'b01000);          // MAX - MAX = 0
        SUBS_test(32'h80000000, 32'h80000000, 5'b01000);          // MIN - MIN = 0
        SUBS_test(32'h7FFFFFFF, 1, 5'b01000);                // MAX - 1
        SUBS_test(32'h80000000, 1, 5'b01000);                // MIN - 1 (no overflow)
        SUBS_test(0, 32'h80000000, 5'b01000);                // 0 - MIN (overflow)
        SUBS_test(32'h7FFFFFFF, 32'h80000000, 5'b01000);          // MAX - MIN (overflow)

//################################################################################################################################

MULTU_test(
32'h0000_000A, // A
            32'h0000_0009, // B
            5'b01001      // ALUControl for ADDU
            
);
// signed multi
//##################################################################################################################################
MULTS_test(
            32'hFFFF_FFFE, // A (-2 in signed representation)
            32'h0000_0002, // B (2)
            5'b01010     // ALUControl for MULTS (Signed Multiply)
           
        );

// Identity and zero tests
        
        MULTS_test(0, 0, 5'b01010 );//"0 * 0"
        MULTS_test(1, 32'h7FFFFFFF, 5'b01010 );
        MULTS_test(1, 32'h80000000, 5'b01010 );
        MULTS_test(0, 32'h80000000,5'b01010  );
        
        // Edge cases
       
        MULTS_test(32'h7FFFFFFF, 1,5'b01010  );
        MULTS_test(32'h7FFFFFFF, 2,5'b01010  );  // Overflow
        MULTS_test(32'h80000000, 1, 5'b01010 );
        MULTS_test(32'h80000000, -1,5'b01010  ); // Overflow
        MULTS_test(32'h7FFFFFFF, 32'h7FFFFFFF,5'b01010  );
        MULTS_test(32'h80000000, 32'h80000000,5'b01010  );
        
         
        MULTS_test(32'hAAAAAAAA, 32'h55555555,5'b01010  );
        MULTS_test(32'hFFFF0000, 32'h0000FFFF,5'b01010  );
        MULTS_test(32'h12345678, 32'h87654321,5'b01010  );

//#####################################################################################

#10;

//########################################################################################
AND_test(
32'h0000_000B, // A
            32'h0000_0008, // B
            5'b00000      // ALUControl for ADDU
            //32'h0000_0008, // Expected Result
        
);


        AND_test(32'h00000000, 32'h00000000, 5'b00000);  // 0 AND 0
        AND_test(32'hFFFFFFFF, 32'hFFFFFFFF,5'b00000);  // All 1s AND All 1s
        AND_test(32'hAAAAAAAA, 32'h55555555, 5'b00000);  // Alternating bits
        
        // Masking tests
        AND_test(32'h12345678, 32'h0000FFFF,5'b00000);  // Mask lower 16 bits
        AND_test(32'hDEADBEEF, 32'hFF000000, 5'b00000);  // Mask upper 8 bits
        
        // Edge cases
        AND_test(32'h80000000, 32'h80000000, 5'b00000);  // MSB set
        AND_test(32'h7FFFFFFF, 32'h80000000,5'b00000 );  // Max positive AND min negative
        
       
            AND_test($random, $random,5'b00000);
       
//#######################################################################################################################    
OR_test(
	    32'h0000_000B, // A
            32'h0000_0008, // B
            5'b00001     // ALUControl for ADDU
            //32'h0000_000B, // Expected Result
           


);

NAND_test(
32'h0000_000B, // A
            32'h0000_0008, // B
            5'b00011      // ALUControl for ADDU
            //32'h0000_0007, // Expected Result
            


);

XOR_test(   
            32'h0000_000B, // A
            32'h0000_0008, // B
            5'b00010      // ALUControl for ADDU
            //32'h0000_0003, // Expected Result
           );
//NOT
NOT_test(
	    32'h0000_000B, // A
            32'h0000_0000, // B
            5'b00100     // ALUControl for ADDU
            //32'hffff_fff4, // Expected Result
          );

        
  SLT_test(
	32'h0000_0005, 
	32'h0000_000A, 
	5'b01011
	
);

//SEQ
  SEQ_test(
	32'h0000_0005, 
	32'h0000_0005, 
	5'b01101
	
);

//SNEQ
  SNEQ_test(
	32'h0000_0005, 
	32'h0000_0006, 
	5'b01110
	
);

//SLE
  SLE_test(
	32'h0000_0005, 
	32'h0000_0005, 
	5'b01111
	
);

//SGE
  SGE_test(
	32'h0000_0008, 
	32'h0000_0005, 
	5'b10000
	
);
//SEQZ

#10;
test_case_SEQZ(
32'h0000_0000,
5'b10101

);
//SNEZ
test_case_SNEZ(
32'h0000_0001,
5'b10110
);
//SNEG
test_case_SNEG(
32'hFFFF_FFFF,
5'b10111
);
//SPOS
test_case_SPOS(
32'h0000_0005,
5'b11000
);

    
        #10000;
        $finish;
end
endmodule 