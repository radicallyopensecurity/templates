#!/usr/bin/env ruby
require 'ostruct'

def build(project)
  puts "pdflatex -halt-on-error #{project.mainfile} && pdflatex -halt-on-error #{project.mainfile}"
  system("pdflatex","-halt-on-error",project.mainfile,"&&","pdflatex","-halt-on-error",project.mainfile)
end

def watch(project)
  if `which when-changed`.include? "not found"
    puts "please install when-changed first"
    exit
  end
  system("when-changed #{project.inputs} -c 'pdflatex -halt-on-error #{project.mainfile} && pdflatex -halt-on-error #{project.mainfile}'")
end

def usage
  puts "./make.rb $command [$project]"
  puts "  currently known commands:"
  $commands.each_pair do |command,_|
    puts "    #{command}"
  end
  puts "  currently known projects:"
  $projects.each_pair do |proj,_|
    puts "    #{proj}"
  end
  exit(1)
end

report = OpenStruct.new(mainfile: "report.tex", inputs: "common/ros-logo.png common/ros.tex report.tex")

$projects = {report: report}
$commands = {
  build: lambda{|proj| build(proj)},
  watch: lambda{|proj| watch(proj)},
  clean: lambda{|_| system("rm *.aux *.log *.toc *.out")}
}

usage unless ARGV.length > 0
op = ARGV[0].to_sym
usage unless $commands.include? op
func = $commands[op]
arg = (ARGV[1] || "report").to_sym
usage unless $projects.include? arg
func.call($projects[arg])
