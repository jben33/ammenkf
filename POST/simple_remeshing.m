line_color;
fsize=40;
figure('Name','simple_remeshing','DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
axis off; 
mesh{1} = [ 0 0.15   0.55 0.775 1 ];
mesh{2} = [ 0 0.55  0.775 1 ];
mesh{3} = [ 0 0.275  0.55 0.775 1 ];

vals{3} = [ 1 1 1 1 1];
vals{2} = [ 2 2 2 2  ];
vals{1} = [ 3 3 3 3 3];


name{3} = { 'z(t,1)', 'z^*(t)', 'z(t,3)', 'z(t,4)', 'z(t,5)' };
name{2} = { 'z(t,1)', 'z(t,3)', 'z(t,4)', 'z(t,5)' };
name{1} = { 'z(t,1)', 'z(t,2)', 'z(t,3)', 'z(t,4)', 'z(t,5)' };

lab = { '(a)' '(b)' '(c)' };

hold on;
p1 = plot(mesh{1}(:), vals{1}(:), 'k', 'Marker', 's' );
p1.MarkerSize=18; p1.MarkerFaceColor=cblk{3};
p1.LineWidth=5;
p2 = plot(mesh{2}(:), vals{2}(:), 'k', 'Marker', 's');
p2.MarkerSize=18; p2.MarkerEdgeColor=cblk{1}; p2.MarkerFaceColor=cblk{3};
p2.LineWidth=5;
p3 = plot(mesh{3}(:), vals{3}(:), 'k', 'Marker', 's');
p3.MarkerSize=18; p3.MarkerEdgeColor=cblk{1}; p3.MarkerFaceColor=cblk{3};
p3.LineWidth=5;

p4 = plot(mesh{1}(2), vals{1}(2), 'Marker', 's');
p4.MarkerSize=25; p4.MarkerEdgeColor=cred{1}; p4.MarkerFaceColor=cred{3};
p5 = plot(mesh{2}(2), vals{2}(2), 'Marker', 's');
p5.MarkerSize=25; p5.MarkerEdgeColor=cred{1}; p5.MarkerFaceColor=cred{3};
p6 = plot(mesh{3}(2), vals{3}(2), 'Marker', 's');
p6.MarkerSize=25; p6.MarkerEdgeColor=cgrn{1}; p6.MarkerFaceColor=cgrn{3};

for i = 1:3
	ss = size(mesh{i},2);
	for j = 2:ss 
		text((mesh{i}(j)+mesh{i}(j-1))/2, vals{i}(j)+.1, num2str(mesh{i}(j)-mesh{i}(j-1)), 'FontSize', fsize, 'HorizontalAlignment', 'center');
	end
end


for i = 1:3
	ss = size(mesh{i},2);
	for j = 1:ss 
		text(mesh{i}(j), vals{i}(j)-.15, name{i}{j}, 'FontSize', fsize, 'HorizontalAlignment','center');
	end
end


for i = 1:3 
	text(mesh{i}(1) - .08, vals{i}(1), lab{i}, 'FontSize', fsize, 'HorizontalAlignment','center');
end


	text(mesh{2}(4) + .1, vals{2}(1), strcat('\delta_{1} = 0.2, \delta_{2} = 0.5'), 'FontSize', 45, 'HorizontalAlignment','center', 'Rotation', 90);
