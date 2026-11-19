// 数据类型

// WIRE,线网

/* 
 wire 类型表示硬件单元之间的物理连线，由其连接的器件输出端连续驱动。
 如果没有驱动元件连接到 wire 型变量，缺省值一般为 "Z"。
*/

wire interrupt;
wire flag1, flag2;
wire gnd=1'b0;

/*
线网型还有其他数据类型，包括 wand，wor，wri，triand，trior，trireg 等。
这些数据类型用的频率不是很高，这里不做介绍
*/

// REGISTER,寄存器

/*
寄存器（reg）用来表示存储单元，它会保持数据原有的值，直到被改写。声明举例如下：
*/

reg clk_temp;
reg flag1, flag2;

// VECTOR,向量
// 当位宽大于 1 时，wire 或 reg 即可声明为向量的形式
reg [3:0] counter; // 声明4bit位宽的寄存器counter
reg [32-1:0] gpio_data; //声明32bit位宽寄存器
wire [8:2] addr; //声明7bit位宽的线型变量addr，位宽范围为8:2
reg [0:31] data; //声明32bit位宽的寄存器变量data, 最高有效位为0

// 对于上面的向量，我们可以指定某一位或若干相邻位，作为其他逻辑使用。例如：
wire [9:0] data_low = data[0:9];
addr_temp [3:2] = addr[8:7] + 1'b1;

// Verillog 还支持指定 bit 位后固定位宽的向量域选择访问。
// 相当于offset

reg [31: 0] data1;
reg [7: 0] byte1 [3:0];

A = data1[31-: 8];
A = data1[31: 24];


B = data1[0+: 8];
B = data1[0: 7];

// 对信号重新进行组合成新的向量时，需要借助大括号。例如：
wire [31: 0] temp1, temp2;
assign temp1 = {byte1[0][7: 0], data1[31:8]};
assign temp2 = {32{1'b0}}; //赋值32位的数值0

// 整数，实数，时间寄存器变量

// integer 位宽和编译器有关，一般32bit,reg为无符号数字，int为有符号

integer i;

// real 实数声明不能带有范围，默认值为 0。如果将一个实数赋值给一个整数，
// 则只有实数的整数部分会赋值给整数

real data2;

integer temp;

initial begin
   data2 = 2e3;
   data2 = 3.75;
end

initial begin
   temp = data2
end

// time， Verilog 使用特殊的时间寄存器 time 型变量，
// 其宽度一般为 64 bit，通过调用系统函数 $time 获取当前仿真时间

time current_time;
initial begin
   // 100;
   current_time = $time;// current_time 的大小为100
end

// array, 在 Verilog 中允许声明 reg, wire, integer, time, real 
// 及其向量类型的数组。



integer flag [7:0];
reg [3: 0] counter [3: 0];
wire [7:0] addr_bus [3: 0];
wire	   data_bit[7:0][5:0];
reg [31:0] data_4d[11:0][3:0][3:0][255:0];

// 一些赋值操作

flag[1] = 32'd0;
counter[3] = 4'hF; // 等价于 counter[3][3:0] = 4'hF

assign addr_bus[0] = 8'b0;
assign adata_bit[0][1] = 1'b1;
data_4d[0][0][0][0][15:0] = 15'd3;

// 存储器变量就是一种寄存器数组，可用来描述RAM, ROM的行为

reg menbit [0:255];
reg [7:0] mem[0:1023];

mem[511] = 8'b0;

// 参数，parameter,表示常量，只能赋值1次

parameter data_width = 10'd32
parameter i=1, j=2, k=3;
parameter mem_size = data_width * 10;

// 局部参数用 localparam 来声明，其作用和用法与 parameter 相同，
// 区别在于它的值不能被改变。所以当参数只在本模块中调用时，可用 
// localparam 来说明。

reg [0: 14*8 - 1] str;
initial begin
    str  = "run.runoob.com";
end


