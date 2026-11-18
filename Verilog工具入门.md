# Verilog 工具安装与使用

学习 Verilog 入门时，可以使用编辑器编写代码，通过 Icarus Verilog 编译和仿真，再用 GTKWave 查看波形。暂时不需要 FPGA 开发板。

## 1. 安装工具

在 Debian / Ubuntu 终端中执行：

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

检查是否安装成功：

```bash
iverilog -V
vvp -V
gtkwave --version
```

`vvp` 会随 Icarus Verilog 一起安装。GTKWave 需要图形桌面或能够显示图形窗口的环境。

## 2. 常用命令

| 命令 | 作用 | 示例 |
|---|---|---|
| `iverilog` | 编译 Verilog 电路和测试文件 | `iverilog -o sim and_gate.v and_gate_tb.v` |
| `vvp` | 运行编译后的仿真程序 | `vvp sim` |
| `gtkwave` | 打开仿真生成的波形文件 | `gtkwave wave.vcd` |

常见的 `iverilog` 参数：

| 参数 | 作用 |
|---|---|
| `-o sim` | 将编译结果保存为 `sim` |
| `-s and_gate_tb` | 指定仿真顶层模块为 `and_gate_tb` |
| `-Wall` | 开启常见警告 |
| `-g2012` | 启用 SystemVerilog 2012 语言模式；不代表支持全部 SystemVerilog 特性 |

## 3. 完整示例：与门仿真

下面的两个文件需要自行创建，并放在同一个目录中。本文中的代码块不会自动生成这些文件。

### 3.1 创建电路文件 `and_gate.v`

与门的两个输入都为 1 时，输出才为 1。

```verilog
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a & b;
endmodule
```

### 3.2 创建测试文件 `and_gate_tb.v`

测试文件称为 testbench，负责给电路输入信号、观察输出。

```verilog
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
```

代码说明：

- `` `timescale 1ns/1ps ``：时间单位是 1 ns，时间精度是 1 ps。
- `#10`：在当前时间单位下等待 10 ns。
- `$dumpfile`：指定波形输出文件名。
- `$dumpvars(0, and_gate_tb)`：记录该模块及其下层模块的信号。
- `$monitor`：所监视的值变化时，在终端打印结果。
- `$finish`：结束仿真。
- `dut`：电路实例名，通常用来表示被测试的设计。

### 3.3 编译

在两个文件所在目录执行：

```bash
iverilog -Wall -s and_gate_tb -o sim and_gate.v and_gate_tb.v
```

编译成功后生成 `sim` 文件。出现报错时，需要先修正代码，再重新编译。

### 3.4 运行仿真

```bash
vvp sim
```

终端会打印输入和输出，同时在当前工作目录生成 `wave.vcd`。

预期逻辑结果：

| 时间（ns） | a | b | y |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 10 | 0 | 1 | 0 |
| 20 | 1 | 0 | 0 |
| 30 | 1 | 1 | 1 |

`%0t` 的终端显示单位可能与上表不同。例如，在此时间精度设置下，10 ns 可能显示为 `10000`（ps），不影响电路逻辑结果。

### 3.5 查看波形

```bash
gtkwave wave.vcd
```

打开 GTKWave 后：

1. 展开左侧模块树中的 `and_gate_tb`。
2. 选择信号 `a`、`b`、`y`。
3. 通过 Append 或拖动，将信号添加到波形区。
4. 使用 Zoom Fit（缩放至完整时间范围）查看整个仿真过程。

## 4. 日常操作流程

修改代码后，重新编译并运行：

```bash
iverilog -Wall -s and_gate_tb -o sim and_gate.v and_gate_tb.v
vvp sim
gtkwave wave.vcd
```

每次都先确认编译成功，再执行仿真，避免运行上一次留下的 `sim` 文件。GTKWave 已打开时，可以重新加载波形文件查看新的结果。

完整流程：**编写电路和测试文件 → 编译 → 运行仿真 → 查看终端结果和波形**。

## 5. 官方资料

- [Icarus Verilog 安装说明](https://steveicarus.github.io/iverilog/usage/installation.html)
- [GTKWave 文档](https://gtkwave.github.io/gtkwave/)
