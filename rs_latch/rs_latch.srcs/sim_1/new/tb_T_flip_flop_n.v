`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 10:18:05 AM
// Design Name: 
// Module Name: tb_T_flip_flop_n
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_T_flip_flop_n;
    reg clk;
    reg reset_p;
    reg t;
    wire q;

    // T 플립플롭 인스턴스
    t_flip_flop uut(
        .clk(clk),
        .reset_p(reset_p),
        .t(t),
        .q(q)
    );

    // 클럭 생성 (10ns 주기 = 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 테스트 시퀀스
    initial begin
        // 초기화
        reset_p = 1;
        t = 0;
        
        // 파형 출력을 위한 모니터
        $monitor("Time=%0t reset_p=%b t=%b clk=%b q=%b", $time, reset_p, t, clk, q);
        
        #10 reset_p = 0;  // 리셋 해제
        
        // T=1일 때 클럭마다 토글 확인
        #5 t = 1;
        #20;  // 2 클럭 사이클
        
        // T=0일 때 상태 유지 확인  
        t = 0;
        #20;  // 2 클럭 사이클
        
        // 다시 T=1로 토글 테스트
        t = 1;
        #20;  // 2 클럭 사이클
        
        // 동작 중 리셋 테스트
        reset_p = 1;
        #10;
        reset_p = 0;
        
        // 리셋 후 정상 동작 확인
        t = 1;
        #30;  // 3 클럭 사이클
        
        $finish;
    end

endmodule

module tb_up_count_asyc;
    reg clk;
    reg reset_p;
    wire [3:0]count;

    up_counter_asyc uut(
        .clk(clk),
        .reset_p(reset_p),
        .count(count)
    );  
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset_p = 1;
        #10;
        reset_p = 0;
        #300;
        $finish;
    end
endmodule

module tb_down_counter_asyc;
    reg clk;
    reg reset_p;
    wire [3:0]count;

    down_counter_asyc uut(
        .clk(clk),
        .reset_p(reset_p),
        .count(count)
    );  
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset_p = 1;
        #20;
        reset_p = 0;
        #300;
        $finish;
    end
endmodule

module tb_up_counter_p;
    reg clk;
    reg reset_p;
    reg enable;
    wire [3:0] up_count;
    
    up_counter_p uut(
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .count(up_count)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p = 1;
        enable = 0;
        
        #10; reset_p = 0;
        #10; enable = 1;
        
        #200;
        
        enable = 0;
        #20;
        
        reset_p = 1;
        #10; reset_p = 0;
        #20;
        
        $finish;
    end
    
    
endmodule


module tb_down_counter_n;
    reg clk;
    reg reset_p;
    reg enable;
    wire [3:0] down_count;
    
    down_counter_n uut(
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .count(down_count)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p = 1;
        enable = 0;
        
        #10; reset_p = 0;
        #10; enable = 1;
        
        #200;
        
        enable = 0;
        #20;
        
        reset_p = 1;
        #10; reset_p = 0;
        #20;
        
        $finish;
    end
    
    
endmodule

