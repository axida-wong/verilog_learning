`timescale 1ns/1ps

module and_gate_tb;
    reg a;
    reg b;
    wire y;

    // 连接被测试的电路
    and_gate dut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // 保存波形，供 GTKWave 查看
        $dumpfile("wave.vcd");
        $dumpvars(0, and_gate_tb);

        // 输入或输出变化时，打印当前值
        $monitor("time=%0t a=%b b=%b y=%b", $time, a, b, y);

        a = 0; b = 0;
        #10;
        a = 0; b = 1;
        #10;
        a = 1; b = 0;
        #10;
        a = 1; b = 1;
        #10;

        $finish;
    end
endmodule
