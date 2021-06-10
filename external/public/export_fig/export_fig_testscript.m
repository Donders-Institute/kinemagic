addpath(fullfile(filesep,'home','common','matlab','eeg-tms','public','export_fig'));

load clown
figure;
imagesc(X)
colormap(map)
set(gcf,'Color','w');
axis off

fname = 'clown_test';
export_fig(fname,'-png');
export_fig(fname,'-pdf');
export_fig(fname,'-eps');

% Maybe you could use pdf2ps intstead of pdftops...
pdf2ps_path = fullfile(filesep,'opt','ghostscript','bin','pdf2ps');
tcmd = regexp(cmd,'("[^"]*")','match');
tcmd = sprintf(' %s',tcmd{:});
tcmd = strrep(tcmd,'.eps','.ps');
[varargout{1:nargout}] = system(sprintf('"%s" %s', xpdf_path, tcmd));

% And then use ps2epsi to get from the ps file to an eps file.