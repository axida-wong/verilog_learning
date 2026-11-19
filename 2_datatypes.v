// 四种基本的值

// 0： 逻辑0, 假
// 1： 逻辑1, 真
// x或X： 未知
// z或Z： 高阻

// 整数的表示法： 十进制d,D; 十六进制h,H；二进制b，B；八进制o,O；
// 数值可以指明位宽

// 4'b1011
// 32'h3022_c0de

// 直接写数字，默认10进制

counter = 'd100;
counter = 100;
counter = 32'h64;
// 负数

-6'd15;

// 字符串

reg [0: 14*18-1] str;
initial begin
   str = "www.runoob.com";
end
