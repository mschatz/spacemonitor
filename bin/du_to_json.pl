#!/usr/bin/perl -w
use strict;

my $root = shift @ARGV;
$root = "/seq/schatz" if !defined $root;

my $selfname = ".extra";
my $treesize = 1024*1024;

print "{\n";
print "  \"cols\": [ \n";
print "     {\"id\":\"dir\",    \"label\":\"dir\",    \"type\":\"string\"},\n";
print "     {\"id\":\"parent\", \"label\":\"parent\", \"type\":\"string\"},\n";
print "     {\"id\":\"size\",   \"label\":\"size\",   \"type\":\"number\"},\n";
print "     {\"id\":\"color\",  \"label\":\"color\",  \"type\":\"number\"}\n";
print "  ],\n";
print "\n";
print "  \"rows\": [ \n";

my $first = 1;

my @suffixes = ("KB", "MB", "GB", "TB", "PB");

my %sizes;

while (<>)
{
  chomp;
  my ($size, $path) = split /\s+/, $_;
  $path =~ s/\/$//;

  my @dirs = split /\//, $path;

  pop @dirs;
  my $parent = join("/", @dirs);

  $sizes{$path}->{size} = $size;
  $sizes{$path}->{parent} = $parent;

  if ($path ne $root)
  {
    $sizes{$parent}->{childsize} += $size;
  }
}


foreach my $path (keys %sizes)
{
  my $size = $sizes{$path}->{size};

  if (exists $sizes{$path}->{childsize})
  {
    my $csize = $sizes{$path}->{childsize};
  
    ## Missing data
    if ($csize < $size)
    {
       my $cpath = "$path/$selfname";
       my $cdiff = $size-$csize;
  
       $sizes{$cpath}->{size} = $cdiff;
       $sizes{$cpath}->{parent} = $path;
    }
  }
}

foreach my $path (sort keys %sizes)
{
  my $parent = $sizes{$path}->{parent};
  my $size   = $sizes{$path}->{size};

  if ($path eq $root) { $parent = "null"; }
  else { $parent = "\"$parent\""; }

  my $printsize = $size;
  my $sizescale = 0;

  while ($printsize > 1024)
  {
    $printsize /= 1024;
    $sizescale++;
  }

  $printsize = sprintf ("%0.02f", $printsize);
  my $sizesuffix = $suffixes[$sizescale];

  my $color = int(10*log ($size)/log(2));
  $size = int($size / $treesize);

  print ",\n" if (!$first);
  print "       {\"c\": [{\"v\":\"$path\", \"f\":\"$printsize $sizesuffix :: $path\"}, {\"v\":$parent}, {\"v\":$size}, {\"v\":$color}]}";

  $first = 0;
}

print "  ]\n";
print "}\n";
