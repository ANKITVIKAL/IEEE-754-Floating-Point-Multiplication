`timescale 1ns / 1ps

module hp_class_tb;
  reg [15:0] f;
  wire snan, qnan, infinity, zero, subnormal, normal;
  
  integer i, nSnans, nQnans, nInfinities, nZeroes, nSubnormals, nNormals;
  
  initial
    begin
      assign f = 0;
      nSnans = 0;
      nQnans = 0;
      nInfinities = 0;
      nZeroes = 0;
      nSubnormals = 0;
      nNormals = 0;
//      $monitor("f = %x, class = %b", f,
//       {snan, qnan, infinity, zero, subnormal, normal});
    end
     
  initial
    begin
      for (i = 0; i < (i << 16); i = i + 1)
        begin
          #10 assign f = i;
          if ((snan & ~qnan & ~infinity & ~zero & ~subnormal & ~normal) == 1)
            nSnans = nSnans + 1;
          else if ((~snan & qnan & ~infinity & ~zero & ~subnormal & ~normal) == 1)
            nQnans = nQnans + 1;
          else if ((~snan & ~qnan & infinity & ~zero & ~subnormal & ~normal) == 1)
            nInfinities = nInfinities + 1;
          else if ((~snan & ~qnan & ~infinity & zero & ~subnormal & ~normal) == 1)
            nZeroes = nZeroes + 1;
          else if ((~snan & ~qnan & ~infinity & ~zero & subnormal & ~normal) == 1)
            nSubnormals = nSubnormals + 1;
          else if ((~snan & ~qnan & ~infinity & ~zero & ~subnormal & normal) == 1)
            nNormals = nNormals + 1;
          else
            begin
              $display("Error: f = %x, class = %b", f, {snan, qnan, infinity, zero, subnormal, normal});
              $stop;
            end
        end
     
      // Output test results   
      begin
        $display("     Number of sNaNs: %d", nSnans);
        $display("     Number of qNaNs: %d", nQnans);
        $display("Number of Infinities: %d", nInfinities);
        $display("    Number of Zeroes: %d", nZeroes);
        $display("Number of Subnormals: %d", nSubnormals);
        $display("   Number of Normals: %d", nNormals);
        $display("               Total: %d (%x)", nSnans+nQnans+nInfinities+nZeroes+nSubnormals+nNormals,
         nSnans+nQnans+nInfinities+nZeroes+nSubnormals+nNormals);
      end
      
      #10 $stop;
    end

  hp_class inst1(f, snan, qnan, infinity, zero, subnormal, normal);

endmodule
