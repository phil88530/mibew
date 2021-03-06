#!/usr/bin/perl

##################################################################
# Arguments
##################################################################

$targetFolder = "deploy";
$suffix = "164";

##################################################################
# Copies tree into target folder, preprocess .phps
##################################################################

sub process_dir($$) {
	my ($from,$to) = @_;
	opendir(DIR, $from) || die "can't opendir $from: $!";
    my @content = readdir(DIR);
    closedir DIR;
    mkdir $to;
    
	for(grep { -f "$from/$_" && ($_ !~ /^\./ || $_ eq ".htaccess" || $_ eq ".keep") } @content) {
		my ($source,$target) = ("$from/$_","$to/$_");

		open (IN,"$source");
		binmode(IN);
		open (OUT,">$target");
		binmode(OUT);
		print OUT $buffer while (read (IN,$buffer,65536));
	}
	
	for(grep { -d "$from/$_" && $_ !~ /^\./ } @content) {
		process_dir("$from/$_","$to/$_");
	} 
}

##################################################################
# Main
##################################################################

`rm -rf $targetFolder`;
die "Target folder exists: $targetFolder" if -e $targetFolder;

process_dir("./webim", $targetFolder);

`rm -rf release$suffix`;
die "release folder exists: release$suffix" if -e "release$suffix";
mkdir "release$suffix";

chdir "$targetFolder";

`zip -r ../release$suffix/mibew${suffix}_all.zip * .htaccess`;

chdir "locales";

`zip -r ../../release$suffix/mibew${suffix}_cs.zip cs`;
`rm -rf cs`;

`zip -r ../../release$suffix/mibew${suffix}_fi.zip fi`;
`rm -rf fi`;

`zip -r ../../release$suffix/mibew${suffix}_da.zip da`;
`rm -rf da`;

`zip -r ../../release$suffix/mibew${suffix}_el.zip el`;
`rm -rf el`;

`zip -r ../../release$suffix/mibew${suffix}_lv.zip lv`;
`rm -rf lv`;

`zip -r ../../release$suffix/mibew${suffix}_fa.zip fa`;
`rm -rf fa`;

`zip -r ../../release$suffix/mibew${suffix}_nl.zip nl`;
`rm -rf nl`;

`zip -r ../../release$suffix/mibew${suffix}_th.zip th`;
`rm -rf th`;

`zip -r ../../release$suffix/mibew${suffix}_ar.zip ar`;
`rm -rf ar`;

`zip -r ../../release$suffix/mibew${suffix}_bg.zip bg`;
`rm -rf bg`;

`zip -r ../../release$suffix/mibew${suffix}_ca.zip ca`;
`rm -rf ca`;

`zip -r ../../release$suffix/mibew${suffix}_de.zip de`;
`rm -rf de`;

`zip -r ../../release$suffix/mibew${suffix}_ru.zip ru`;
`rm -rf ru`;

`zip -r ../../release$suffix/mibew${suffix}_ro.zip ro`;
`rm -rf ro`;

`zip -r ../../release$suffix/mibew${suffix}_hu.zip hu`;
`rm -rf hu`;

`zip -r ../../release$suffix/mibew${suffix}_fr.zip fr`;
`rm -rf fr`;

`zip -r ../../release$suffix/mibew${suffix}_it.zip it`;
`rm -rf it`;

`zip -r ../../release$suffix/mibew${suffix}_ka.zip ka`;
`rm -rf ka`;

`zip -r ../../release$suffix/mibew${suffix}_pl.zip pl`;
`rm -rf pl`;

`zip -r ../../release$suffix/mibew${suffix}_pt-br.zip pt-br`;
`rm -rf pt-br`;

`zip -r ../../release$suffix/mibew${suffix}_sp.zip sp`;
`rm -rf sp`;

`zip -r ../../release$suffix/mibew${suffix}_sv.zip sv`;
`rm -rf sv`;

`zip -r ../../release$suffix/mibew${suffix}_ua.zip ua`;
`rm -rf ua`;

`zip -r ../../release$suffix/mibew${suffix}_he.zip he`;
`rm -rf he`;

`zip -r ../../release$suffix/mibew${suffix}_hr.zip hr`;
`rm -rf hr`;

`zip -r ../../release$suffix/mibew${suffix}_tr.zip tr`;
`rm -rf tr`;

`zip -r ../../release$suffix/mibew${suffix}_zh-cn.zip zh-cn`;
`rm -rf zh-cn`;

`zip -r ../../release$suffix/mibew${suffix}_zh-tw.zip zh-tw`;
`rm -rf zh-tw`;

chdir "..";
`zip -r ../release$suffix/mibew$suffix.zip * .htaccess`;

chdir "..";
`rm -rf $targetFolder`;
