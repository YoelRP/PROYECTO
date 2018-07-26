////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 1999-2008 Easics NV.
// This source file may be used and distributed without restriction
// provided that this copyright statement is not removed from the file
// and that any derivative work contains the original copyright notice
// and the associated disclaimer.
//
// THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
//
// Purpose : synthesizable CRC function
//   * polynomial: x^5 + x^2 + 1
//   * data width: 5
//
// Info : tools@easics.be
//        http://www.easics.com
////////////////////////////////////////////////////////////////////////////////
module CRC5_D11(
  nextCRC5_D11,
  Data,
  crc
  );
    output reg [4:0] nextCRC5_D11;
        input wire [10:0] Data;
    input wire [4:0] crc;
    reg [10:0] d;
    reg [4:0] c;
    reg [4:0] newcrc;


  always @ (*) 
    begin
    d [10:0] = Data [10:0];
    c [4:0] = crc [4:0];

    newcrc[0] = d[10] ^ d[9] ^ d[6] ^ d[5] ^ d[3] ^ d[0] ^ c[0] ^ c[3] ^ c[4];
    newcrc[1] = d[10] ^ d[7] ^ d[6] ^ d[4] ^ d[1] ^ c[0] ^ c[1] ^ c[4];
    newcrc[2] = d[10] ^ d[9] ^ d[8] ^ d[7] ^ d[6] ^ d[3] ^ d[2] ^ d[0] ^ c[0] ^ c[1] ^ c[2] ^ c[3] ^ c[4];
    newcrc[3] = d[10] ^ d[9] ^ d[8] ^ d[7] ^ d[4] ^ d[3] ^ d[1] ^ c[1] ^ c[2] ^ c[3] ^ c[4];
    newcrc[4] = d[10] ^ d[9] ^ d[8] ^ d[5] ^ d[4] ^ d[2] ^ c[2] ^ c[3] ^ c[4];
    nextCRC5_D11 = newcrc;
    end

endmodule