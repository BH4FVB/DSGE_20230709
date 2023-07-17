% make directary 新建文件夹
clear;clc;
mkdir('.\results')

% set_param_value('sigma',sigma)赋值函数的好处：
% 可以从外界给参数赋值，不必反复编写多个参数不同的mod文件
% linear equations:sigma=2.10
clear;clc;
sigma = 2.10;
dynare Benchmark_Linear.mod;
% oo_:储存模型计算结果，
% 包括政策函数、转移函数、方差协方差矩阵等
% 不必反复计算，需要结果时直接调用
sigmaHigh_o = oo_;
% M_:储存模型基本设定
sigmaHigh_m = M_;
save('./results./sigmaHigh_o.mat','sigmaHigh_o');
save('./results./sigmaHigh_m.mat','sigmaHigh_m');

% linear equations:sigma=0.87
clear;clc;
sigma = 0.87;
dynare Benchmark_Linear.mod;
sigmaLow_o = oo_;
sigmaLow_m = M_;
save('./results./sigmaLow_o.mat','sigmaLow_o');
save('./results./sigmaLow_m.mat','sigmaLow_m');

% impulse response analysis 脉冲反应分析
% 不使用dynare自动绘制的图形，而是通过脚本调用数据重新绘图
% 清除工作区所有变量
clear;
% 清除命令行窗口
clc;
% 关闭所有弹出窗口
close all;
% 加载计算结果和模型设定（sigma两种赋值）
load('./results./sigmaHigh_o.mat');
load('./results./sigmaHigh_m.mat');
load('./results./sigmaLow_o.mat');
load('./results./sigmaLow_m.mat');

% 绘制脉冲反应函数
% x:1到15的整数等差数列
T = 15; x = 1:T;
% 新建图形窗口名称为h
h = figure;
% h的设定：
% [1 1 18 10] 18厘米长，10厘米宽
set(h, 'unit','centimeters','position',[1 1 18 10]);

% 图h中画2行4列的小图，其中的第一个图
subplot(2, 4 ,1);
% 第一个小图的内容：y（产出）的脉冲反应
% x轴sigmaHigh_o.mat中y对etaa脉冲反应函数的横轴，
% sigmaHigh_o.irfs.y_etaa(x)*100 *100指100%
% 且只取前15期：x = 1:T
% k-:黑色，实线 r-红色，实线
plot(x, sigmaHigh_o.irfs.y_etaa(x)*100,'k-',x,sigmaLow_o.irfs.y_etaa(x)*100,'r-');
ylabel('(%)')
title('y','FontSize',12)

% 第二个图
subplot(2, 4 ,2);
% 第一个小图的内容：c的脉冲反应
% x轴sigmaHigh_o.mat中y对etaa脉冲反应函数的横轴，
% sigmaHigh_o.irfs.y_etaa(x)*100 *100指100%
% 且只取前15期：x = 1:T
% k-:黑色，实线 r-红色，实线
plot(x, sigmaHigh_o.irfs.c_etaa(x)*100,'k-',x,sigmaLow_o.irfs.c_etaa(x)*100,'r-');
ylabel('(%)');
title('c','FontSize',12);

% 第三个图
subplot(2, 4 ,3);
% n的脉冲反应
plot(x, sigmaHigh_o.irfs.n_etaa(x)*100,'k-',x,sigmaLow_o.irfs.n_etaa(x)*100,'r-');
ylabel('(%)');
title('n','FontSize',12);

% 第四个图
subplot(2, 4 ,4);
% r的脉冲反应
plot(x, sigmaHigh_o.irfs.r_etaa(x)*100,'k-',x,sigmaLow_o.irfs.r_etaa(x)*100,'r-');
ylabel('(%)');
title('r','FontSize',12);

% 第五个图
subplot(2, 4 ,5);
% w的脉冲反应
plot(x, sigmaHigh_o.irfs.w_etaa(x)*100,'k-',x,sigmaLow_o.irfs.w_etaa(x)*100,'r-');
ylabel('(%)');
title('w','FontSize',12);

% 第六个图
subplot(2, 4 ,6);
% mc的脉冲反应
plot(x, sigmaHigh_o.irfs.mc_etaa(x)*100,'k-',x,sigmaLow_o.irfs.mc_etaa(x)*100,'r-');
ylabel('(%)');
title('mc','FontSize',12);

% 第七个图
subplot(2, 4 ,7);
% a的脉冲反应
plot(x, sigmaHigh_o.irfs.a_etaa(x)*100,'k-',x,sigmaLow_o.irfs.a_etaa(x)*100,'r-');
ylabel('(%)');
title('a','FontSize',12);

% 变量标签
legend({'omega=2.10','omega=0.87'},'FontSize',12,'position',[0.75, 0.1,0.2,0.2]);
legend('boxoff');

% 输出
print(h,'-dpng','./results./benchmark.png');
