module tester;

  /* Make a reset that pulses once. */
  reg reset = 0;
  reg DCI_reg   = 0;
  reg CSC_reg   = 0;
  reg PLC_reg   = 0;
  reg PRC_reg   = 0;
  reg DCE_reg   = 0;
  reg PED_reg   = 0;
  reg CEC_reg   = 0;
  reg clk = 0;
  reg Reset_rcvd_reg = 0 ;
  reg set_config_succesful_reg = 0; 
 reg EnumError_reg = 0 ;   
 reg Deconfigure_reg = 0 ; 

  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);

     # 17 reset = 1;
   
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */

  always #1 clk = !clk;



DbCPortStatMachine DbCPortStatMachine_instance ( 
.clock                   (  clk                       ),
.DCI                     (  DCI_reg                   ),
.CSC                     (  CSC_reg                   ),
.PLC                     (  PLC_reg                   ),
.PRC                     (  PRC_reg                   ),
.DCE                     (  DCE_reg                   ), 
.PED                     (  PED_reg                   ),
.CEC                     (  CEC_reg                   ),
.Reset_rcvd              (  Reset_rcvd_reg            ),
.set_config_succesful    (  set_config_succesful_reg  ),
.EnumError               (  EnumError_reg             ),
.Deconfigure             (  Deconfigure_reg           )
);
endmodule // test