clear;
%加载数据，每个序列为一列，母序列在第一列
load fuwuye.mat
J=[];
J=fuwuye();
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
title('服务业数据初值化图像')
xlabel('年份')
legend ('数字经济总量（万亿元）','科技成果登记数(项)','卫生总费用(亿元)','电子出版物出版数量(万张)','交通运输、仓储和邮政业增加值(亿元)')
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

%计算子序列中各个指标与母序列的关联系数
x_concect = zeros(size(x));
for i = 1: length(x_concect(1,:))
    x_concect(:,i) = abs(x_norm(:, 1) - x_norm(:,i+1));
end
a = min(min(x_concect));
b = max(max(x_concect));
%数据处理后的图像
subplot(2,2,2)
for i = 1:m
    plot(p,Ja(:,i), 'x-');
    hold on 
end
hold off
title('服务业数据标准化后图像')
xlabel('年份')
legend('数字经济总量（万亿元）','科技成果登记数(项)','卫生总费用(亿元)','电子出版物出版数量(万张)','交通运输、仓储和邮政业增加值(亿元)')
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
title('服务业关联系数图像')
xlabel('年份')
legend('科技成果登记数(项)','卫生总费用(亿元)','电子出版物出版数量(万张)','交通运输、仓储和邮政业增加值(亿元)')
%计算关联度
ans = mean(gamma);
disp('最终得到的灰色关联度分别是：')
disp(ans)