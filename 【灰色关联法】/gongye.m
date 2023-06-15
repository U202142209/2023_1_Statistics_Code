%加载数据，每个序列为一列，母序列在第一列
load gongye.mat
J=[];
J=gongye();
p=2015:2021;
%画图
[n ,m]= size(J);
%初值化
for i = 1:m
    for f=1:n
        Ja(f,i)=J(f,i)/J(1,i);
    end
end
subplot(2,2,1)
for i = 1:m
    plot(p,Ja(:,i), 'x-');
    hold on 
end
hold off
title('工业数据初值化图像')
xlabel('年份')
legend('数字经济总量（万亿元）','社会消费品零售总额(亿元)','大中型工业企业管理费用(亿元)','大中型工业企业财务费用(亿元)','大中型工业企业存货(亿元)','计算机、通信和其他电子设备制造业大中型工业企业利润总额(亿元)')

%对变量进行预处理
y = Ja(:,1);
x = Ja(:,2:end);
x_norm = zeros(n ,m);
x_sum = 0;
for i = 1:m
    x_sum = sum(Ja(:,i));
    for j = 1:n
        x_norm(j, i) = Ja(j, i) / x_sum * n;
    end
    x_sum = 0;
end
%处理后的图像
subplot(2,2,2)
for i = 1:m
    plot(p,x_norm(:,i), 'x-');
    hold on 
end
hold off
title('工业数据标准化后图像')
xlabel('年份')
legend('数字经济总量（万亿元）','社会消费品零售总额(亿元)','大中型工业企业管理费用(亿元)','大中型工业企业财务费用(亿元)','大中型工业企业存货(亿元)','计算机、通信和其他电子设备制造业大中型工业企业利润总额(亿元)')

%计算子序列中各个指标与母序列的关联系数
x_concect = zeros(size(x));
for i = 1: length(x_concect(1,:))
    x_concect(:,i) = abs(x_norm(:, 1) - x_norm(:,i+1));
end
a = min(min(x_concect));
b = max(max(x_concect));

%计算灰色关联度（gamma）
rho = 0.5;
gamma = zeros(n, m-1);
for i = 1:m-1
    for j = 1:n
        gamma(j, i) = (a + rho * b)/(x_concect(j,i) + rho * b);
    end
end
%关联系数图像
subplot(2,2,3)
for i = 1:m-1
    plot(p,gamma(:,i), 'x-'); 
    hold on;
end
title('工业数据关联系数图像')
xlabel('年份')
legend('社会消费品零售总额(亿元)','大中型工业企业管理费用(亿元)','大中型工业企业财务费用(亿元)','大中型工业企业存货(亿元)','计算机、通信和其他电子设备制造业大中型工业企业利润总额(亿元)')
%计算关联度
ans = mean(gamma);
disp('最终得到的灰色关联度分别是：')
disp(ans)