
#!/usr/bin/tclsh
puts "*******hello tcl********"
puts "*******hello tcl2********"; #investigate the comments usage: only after the semicolon";", the comments are valid

# ************************************for a given pattern, output the matched  row contents (begin) **************************** 
proc tgreg {pattern filename} {
                               set f [open $filename r+];# open the $filename pointing to the file(where the input to the proc is a direatory plus filename),then let f be the handle of the file,which means that in this proc, $f points to the input file document
															 puts "f:$f"
															 while {[gets $f line]} {;# in while loop, each iteration, variable line obatian the next line of the file(which $f points to)
																			                 puts "line:$line" 
																											 if {$line==""} {;# if $line is blank empty, break the while loop
																															         break
																											                }
																			                 if {[regexp $pattern $line]} {;# each iteration, when the contents of a cartain line match the pattern, print this line.
																															                       puts stdout $line
																											                              }
																											}
                              # puts $f "test";# write "test" into the opened file, which $f pointing to.
                               close $f;# after the operation for the opened file, pls close it. 
														            	 
                              }
															 

set pattern A 
set file_path_name ./file1.txt
tgreg $pattern $file_path_name;# when you wanna access a file, pls invoke the porc by sending the pattern and the file(including diractory and filename)
puts "*********************gap1***************"

# ************************************for a given pattern, output the matched  row contents (end) **************************** 



# first: open a txt file
#second: write into the open file
# 3rd: close the opened file
#4th: open the existing file
#5th : read all of the file content in the opend file
# 6th: close the file 
set fp [open "input.txt" w+];# create and open a file, which name is "input.txt". then let variable fp be the handle of the file (it means fp points to this file, for the "gets" "puts" "close" usage)
puts $fp "test2";# write test2 into the opened file, where $fp points to.
puts $fp "test3";
puts $fp "test44\ntest5"
close $fp
set fp_read [open "input.txt" r]
set file_data [read  $fp_read];# read all of the contents(where $fp_read points to) and assign to variable file_data
puts $file_data
close $fp_read

puts "*********************gap2***************"




set fp [open "input2.txt" w+]
puts $fp "test\nsweet\nheart"
close $fp
#set fp 

set fpp [open "input2.txt" r]
while {[gets $fpp data]>=0} {
                             puts "data:$data"
}
close $fpp


set fpp [open "input2.txt" r]
while {[gets $fpp data]>=0} {
				                      
                             puts "data:$data"
}
close $fpp
puts "*******************gap3***********"


# ******************read the ith row of a file (begin) *********************
proc read_certain_line {line_num filename} {
                                        set f [open $filename r+]
																				set i_index 1
																				while {[gets $f line_content]} {
																				                      				  if {$line_content==""} {
																				                      									            break

																				                      					                   }
                                                                        if {$i_index==$line_num} {
                                                                            puts "the $line_num th line contents:$line_content"
																                              				      }
																                              							incr i_index
																        				                        }

                                        close $f

				                              }


set line_num 3
read_certain_line $line_num  "input2.txt"

puts [pwd]
pwd

#source ./TCL_file_access_study.tcl
cd ../
puts [pwd]
#source ./hello.tcl
#see
# ******************read the ith row of a file (end) *********************



