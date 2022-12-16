`timescale 1ms/1ms
`include "projects/7.parking/parking.v"

module parking_entrance_tb;
  integer i;

  //* inputs
  reg entranceSen,
      doorMaxOpen,
      doorMaxClose;
  reg [5:0] entrancePass;

  //* outputs
  wire doorOpen,
       doorClose,
       okPass,
       wrongPass,
       empty,
       full;
  wire [3:0] carNumber;

  parking uut (
            //* outputs
            .doorOpen(doorOpen),
            .doorClose(doorClose),
            .okPass(okPass),
            .wrongPass(wrongPass),
            .carNumber(carNumber),
            .empty(empty),
            .full(full),

            //* inputs
            .entranceSen(entranceSen),
            .entrancePass(entrancePass),
            .doorMaxOpen(doorMaxOpen),
            .doorMaxClose(doorMaxClose)
          );

  initial
  begin
    $dumpfile("parking_entrance_tb.vcd");
    $dumpvars(0,parking_entrance_tb);

    for(i = 0;i < 20;i++)
    begin
      entranceSen = {$random} % 2;
      #5;

      if (entranceSen)
      begin
        entrancePass = {$random} % 64;
        #10;

        if (doorOpen)
        begin
          doorMaxOpen = 0;
          #10;
          doorMaxOpen = 1;
          #10;
          doorMaxOpen = 0;
        end

        if (doorClose)
        begin
          doorMaxClose = 0;
          #10;
          doorMaxClose = 1;
          #10;
          doorMaxClose = 0;
        end

        entranceSen = 0;
        entrancePass = 0;
      end

      #30;
    end
  end

endmodule