module test;

//实数
real a, b, c;
c = a + b ;

//寄存器
reg  [3:0]       cprmu_1, cprmu_2 ;
always @(posedge clk) begin
        cprmu_2 = cprmu_1 ^ cprmu_2 ;
end
         
//函数
reg  flag1 ;
flag = calculate_result(A, B);
 
//非法操作数
reg [3:0]         res;
wire [3:0]        temp;
always@ (*) begin
    res    = cprmu_2 - cprmu_1 ;
    //temp = cprmu_2 - cprmu_1 ; //不合法，always块里赋值对象不能是wire型
end

endmodule