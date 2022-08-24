#!/usr/bin/tclsh
puts "*******hello tcl********"
puts "*******hello tcl2********"; #investigate the comments usage: only after the semicolon";", the comments are valid

set x 10
set y1 x+100; # here x is a string, so y1 is x+100
puts "y1:$y1"

set y2 $x+100; #here x is a variable as with "$", but y2 is still a string,so y2 is 10+100
puts "y2:$y2"

set y3 [expr $x+100]; # [] is a command substitution, which means that the content within [] is a command, after conducted the command, return the command results to y3. So y3 is 110
puts "y3:$y3"

#set y3_1 [$x+100]; # note: [$x+100] is not a command, so this line is not a legal syntax
set y4 [set yy $x+100];  #the content within [] is a command, after execute the command, return the command results to y4, thus, y4 obtains the value of yy
puts "y4:$y4"

set y5 [set yy_2 $x+100;expr $x+80];# [] return the last command result to y5
puts "y5:$y5"

#Note:
#1.similar to C-shell, directly substitution (y2) means y2 is a string;
#2.if we wanna conduct mathematical operaion, we should use the syntax: set XX [expr xx]; similar to C-shell: @ XX = XX1 +XX2
#3.for TCL language, several commands can be nested together. Typical example: y3 y4 y5
#4.use "puts" to print results. similar to "echo" in C-shell/"display" in Verilog

set msg multiple\ space
puts "msg:$msg"

set msg_2 money\ \$3333\ \nArray\ a\[2\]; # by using backslash "\", we can insert special character
puts "msg_2:$msg_2"

set a_1 \x48
puts "a_1:$a_1";# why a_1 is H, answer: \x+num represents the num value is in Hexdecimal

set a_2 \110
puts "a_2:$a_2";# why a_2 is H, answer: \+num repesents the num value is in decimal

set a_3 [expr 2+3]
puts "a_3:$a_3"

set a_4 [expr \
2+3]
puts "a_4:$a_4"

set xx 100
set y6 "$xx ddd"; # the usage of double quotation "" in TCL is the same as that in C-shell, where the variale with $ can  be recognized
puts "y6:$y6"

set y7 {$xx ddd}; # the usage of brace {} in TCL is the same as single quatation '' in C-shell, where everything within {} would be treated equally. Note: there is no single quatation usage in TCL  
puts "y7:$y7"

#set y8 '$xx ddd';# there is no single quatation usage in TCL  
set y8 {/n$x [expr 12+23]}
puts "y8:$y8"

set a 2
set a.1 4
puts "a.1:${a.1}"


set b1 $a.1
puts "b1:$b1"

set b2 ${a.1}
puts "b2:$b2"

set b3 {beauty beauty}
puts "b3:$b3"

# ***************************the usage of array in TCL language (begin) *****************************
set day(Monday) 1 ; #set the Monday element in day (array) as 1
set day(Tuesday) 2
puts "day:${day(Monday)}"
puts [array size day]; #obtain the size of array
puts "the size of day:[array size day]"
#puts "day:${day}"

#puts "day:${day}"

array set bba {1 bba1 2 bba2 3 bba3};#set the first/second/third elements as bba1/bba2/bba3, respectively. 
parray bba    ;# print array
puts "the first element of array bba:${bba(1)}"
puts "*********************"
#array names bba
#puts "$bba"
# ***************************the usage of array in TCL language (end) *****************************

# ***************************the usage of source in TCL script (begin)**********************************************************************
source ./test.tcl;# in TCL, we can consider "source + filename" as a macro, where add the code contents into this script 
# Note: in TCL, "source" is like a macro, in which you can add other codes in other files into the current file.

# ***************************the usage of source in TCL script (end)*************************************************************************



# ***********************************************************************the usage of file in TCL script (begin)******************************************************

set path $argv0;#obtain this hello.tcl directory and its name ( $argv0 is ./hello.tcl)
puts "atime:[file atime $path]"
puts "argv0 is the script name and its diectory:$argv0"; # $argv0 is ./hello.tcl

# creat file folder
file mkdir ./folder1/folder2
puts "I have mkdir ./folder1/folder2"

# delete file folder2
file delete -force ./folder1/folder2
puts "I have deleted ./folder1/folder2"

file copy -force $path a.txt; #copy this hello.tcl as a.txt

file copy -force a.txt  b.txt; #when copy file, if b.txt is existing, we should add "-force" to forcely cover the existing b.txt
file rename -force b.txt c.txt; #rename b.txt as c.txt


file copy -force a.txt ./folder1/d.txt

file mkdir ./folder3/folder4
file copy -force ./folder1/d.txt ./folder3/folder4; #copy "./folder1/d.txt" into directory "./folder3/folder4" 
file copy -force ./folder1/d.txt ./folder3/folder4/e.txt; #copy "./folder1/d.txt" into directory "./folder3/folder4" and rename as e.txt

# ***********************************************************************the usage of file in TCL script (end)***********************************************************



puts [exec pwd]
set pp1 [exec pwd]; # this line code obtains the script directory, just like dirname command in C-shell script
puts "script location:$pp1"
set path2 $pp1/folder1
puts "path2:$path2"
puts [exec pwd]
puts "exec pwd"
#set pp2 [exec cd path2]
puts "the current directory1:[exec pwd]"
#[exec cd $path2]
cd $pp1/folder1

#cd $path2; # change current directory
puts "the current directory2:[exec pwd]"




# ************************* The typical usage of obtaining the directory coordinate origin and change the current working directory(begin)*********************************************************
puts "the current directory3:[exec pwd]"

set current_working_dir [exec pwd]; #current_working_dir is the current working directory(at this point, it is not the script diretory, as the current working directry has changed before)
puts "the current working directory:$current_working_dir"

set path3 $current_working_dir/../folder3; # based on the "coordicate origin", set another another "coordinate point", which actually is a directory varibale
cd $path3; # change the current working directory
puts "the current directory4:[exec pwd]"

# ************************* The typical usage of obtaining the directory coordinate origin and change the current working directory(end)*********************************************************


# *****************************************use exec to run another progress in TCL script (begin) *********************************************************************************************
cd $pp1 
puts "the current directory5(the script directory):[exec pwd]"
set pogress_to_be_invoke $pp1/folder2

cd $pogress_to_be_invoke
puts "the current directory6:[exec pwd]"
set show_me_directory [exec ls]

puts "show current directory6:[exec ls]"


puts "-------"

puts "[lindex $show_me_directory 0]"
puts "[lindex $show_me_directory 1]"

set bc1 [lindex $show_me_directory 0]
puts "the current directory7:[exec pwd]"

# exec ./$bc1; ?????????????so far, I do not konw how to execute another exeutuable script in TCL?????????????????
# *****************************************use exec to run another progress in TCL script (end) *********************************************************************************************


# ********************************************* The typical usage of append (begin)**********************************************************************
set txt hello
puts "$txt"
append txt ! How are you
puts "the results1:$txt";# you can find : if no double quotation mark for the append contents, there is no blank space included.

append txt "! How are you"
puts "the results2:$txt"

#note of append:
#1.you can find : if no double quotation mark "" for the append contents, there is no blank space included between words.
#2.if you define a varibale previously, such as: set txt hello
#  the syntax of append is: append txt "! how are you" 
#  instead of: append $txt "! how are you"

append $txt "! How are you"
puts "the results3:$txt"

# ********************************************* The typical usage of append (end)0**********************************************************************

# ********************************************* The typical usage of incr (begin)**********************************************************************
set b 3
incr b 2 
puts "b:$b"

set b2 5 
incr b2 $b; # varibale b2 and $b must be integer
puts "b2:$b2"

# ********************************************* The typical usage of incr (end)**********************************************************************

# ********************************************* The typical usage of math function (begin)**********************************************************************
set x 2
set y [expr 2*sin(1)]
puts "the function output:$y"
#set y1 [expr 2*sin({pi}/2)]

set x1 [expr 1+2*5]
puts "$x1"
# ********************************************* The typical usage of math function (end)**********************************************************************


#******************************************************************************************************************************************************
# ********************************************* The typical usage of list (begin)**********************************************************************
#******************************************************************************************************************************************************
set aaa [list 1 2 {3 4}];# variable aaa is a list: {1 2 {3 4}}
puts "$aaa"
#list 1 2 {3 4}
set aaab [list 1 2 {3 5}]

#concat usage
set aa2 [concat $aaa $aaab];# concatenate two list variables 
puts $aa2

# llength usage
set length_aa2 [llength $aa2]
puts "length_aa2:$length_aa2"
set length2 [llength {1 2 3 {5 6}}]
puts "length2:$length2"

# lindex usage
set aaab_2 [lindex {1 2 {3 4}} 2]; #lindex return the (0-based) element
puts "$aaab_2"
set aaab_1 [lindex $aaa 1]; #return the second element in variable $aaa
puts "$aaab_1"


# linsert usage 
set list1 {1 2 {3 4}}
puts "list1:$list1"
set list2 [linsert $list1 1 7];# "set list2 [linsert $list1 N Element]" insert Element into $list1 as the Nth element,   then return to $list2
puts "list1:$list1"
puts "list2:$list2"


#lreplace usage     syntax: lreplace list index_start index_last value1 value2 ...
set list3 {1 7 8 {9 10} 2 {3 4}}
puts "list3: $list3"
lreplace $list3 3 3; # note; this line code means: delte the 3rd element in $list3, but not return to a defined varibale
puts "list3: $list3"
set list4 [lreplace $list3 3 3];# delte the 3rd element in $list3, then return to varibale list4
puts "list4: $list4"
set list5 [lreplace $list3 3 3 { m n}];#replace the 3rd element with {m n} in $list3, then return to variable list5
puts "list5: $list5"
set list6 [lreplace $list3 2 4 { m n} {a b} fg];# replace the 2nd to 4th elements in  $list3 with { m n} {a b} fg ,respectively.
puts "list6: $list6"


#lrange usage
set list7 [lrange $list3 3 end];# obtain the 3rd (based on 0) to the last element an then return to variable list7
puts "list7: $list7"
set list8 [lrange $list3 3 3];# obtain the 3rd element in $list3, then return to varibale list8
puts "list8: $list8"
set list9 [lrange $list3 3 4]; # obtain the 3rd and 4th element in $list3, then return to vriable list9
puts "list9: $list9"

#lappend usage
set list10 {1 2 3}
lappend list10 4 5 5; # append 4 5 5 to the end of list10
puts "list10: $list10"
lappend list11 4 5 5 6 
puts "list11: $list11"
set list12 [lappend list11 a b];# append a b to the end of list11 and then the list11 resullt to variable list12
puts "list11: $list11"
puts "list12: $list12"


#Note of the lappend usage
#1.the syntax is : lappend list10 value1 value2... 
#             Not: lappend $list10 value1 value2 ...
#2.if the variable list10 has not been defined before, "lappend list10 value1 value2..." means : (1)define variable list10 (2) return {value1 value2 ...} to list10
#3. the typical usage of lappend is "lappend list10 value1 value2..."
#                                 not:"set varibale_name1 [lappend list10 value1 value2...]"
#4. in my view,  may becaues "lappend" in TCL includes the function to define new variable (if the varibale has not been defined), the varibales invoked in lappend syntax don't need "$" mark


# compare append and lappend
set list13 {1 2 3}
append list13 abd
puts "list13:$list13"
append list13 " hello abd"
puts "list13:$list13"
lappend list13 abd 
puts "list13:$list13"
#note of the difference append and lappend
# 1. "append list13 abd" just append abd to the end of list13 (not increase the num of element in variable list13)
# 2.  "lappend list13 abd" append abd to the end of list3 as the last element (increase the num of element in variable list13)
# 3. append and "lappend" both can append more than one elements
set var orange
append var " " "blue"
puts "var: $var"
lappend var "green" "red"
puts "var: $var"






# lsearch usage
set list14 {how are y? ou}
lsearch $list14 y*
set index_n [lsearch $list14 y*]; #fuzzy match "y*" in $list14 and return the index to index_n
puts "index_n:$index_n"
set index_n2 [lsearch $list14 y];# exactlly matching "y" in $list14, but no "y" element in list14, so return -1 to index_n2
puts "index_n2:$index_n2"
set index_n3 [lsearch $list14 y?];# exactlly matching "y" in $list14, there is  "y?" element in list14, so return 2 (index) to index_n2
puts "index_n3:$index_n3"


#lsort usage
lsort -integer {5 3 2 11 4}
set list15 [lsort -integer {5 3 2 11 4}]
puts "list15:$list15"
set list16 [lsort -integer {5 3 3 2 11 4}];# (-integer) Convert list elements to integers and use integer comparison.
puts "list16:$list16"
set list17 [lsort -unique {a 3 3 2 11 4 11}];# delete the repeated elements
puts "list17:$list17"
set list18 [lsort -real { 3.2 3 2 11 4 11}];# (-real) Convert list elements to floating-point values and use floating comparison.
puts "list18:$list18"
#****************************************************************************************************************************************************
# ********************************************* The typical usage of list (end)**********************************************************************
#****************************************************************************************************************************************************


# ********************************************* The typical usage of split and join (begin)**********************************************************************
#split syntax: split "string" splitChar  :split the "string" according to splitChar
#          or: split ""string" ": (No splitChar specify), split "string" according to "blank space"
split "how.are.you" .
set split_result1 [split "how.are.you" .];#split "how.are.you" with "."
puts "split_result1:$split_result1"
set split_result2 [split "how are you"];# split "how are you" with blank space
puts "split_result2:$split_result2"

set split_result3 [split "how are you" {}];#????????????????????????????
puts "split_result3:$split_result3"
set length_result3 [llength $split_result3]
puts "length_result3: $length_result3"

set split_result4 [split "how_are_you" _];# split the string with "_" (after the split operation, the returned result is a list)
puts "split_result4:$split_result4"
set length_result4 [llength $split_result4];# return the length of the split result split_result4
puts "length_result4: $length_result4";# you can find: after split operation, the returned result is a list (that's why put list usage and split together)





#join syntax: join list joinString
set list16 {how are you}
join $list16 .
puts "list16: $list16"
set join_result1 [join $list16 .];# join "." into the gap of the list element to become a string, which length is 1
puts "join_result1: $join_result1"
set length_join_result1 [llength $join_result1]
puts "length_join_result1: $length_join_result1"


set list17 {h o w { } a r e { } y o u} 
set join_result2 [join $list17 {}]
puts "join_result2:$join_result2"

#Note for split and join function:
# split: split the string into a list
# join: join a particular joinString into the list to become a string
# ********************************************* The typical usage of split and join (end)**********************************************************************



#**********************************************************************************************************************************************************************
# **************************************************the control flow in TCL (begin)************************************************************************************
#**********************************************************************************************************************************************************************

# **************************************************if...else usage (begin)************************************************************************************
puts "if.....else... usage***************************"
#if...else usage
set a1 100
if {$a1 < 20} { 
				puts "a1 is less than 20" ;#note
   } else { ;# note
				puts "a1 is larger than 20" 
				 }
puts "the value of a1 is $a1"
#note of if... else usage
# 1. the blank space between } and { in the above line is necessary.   Also, the blank space between "if {" is necessary as well.
# 2. the blank space among "} else {" are necessary
# 3. you can not write comments in if...else, otherwise, TCL script would consider the syntax before the comment finished.


# if...elseif...else usage
set a2 60
if {$a2 == 10} {
				         puts "value is 10";#note
} elseif {$a2 == 20} {
                 puts "value is 20"
} elseif {$a2 == 30} {
                 puts "value is 30"
} else {
				         puts "None of the values are matched"
				}				 
puts "the value of a2 is $a2"
    

# the nesting usage of if...else
set a3 200
set a4 500
if {$a3 == 200} {
   if {$a4 == 500} {
					 puts "a3 and a4 both are matched"
	 }
}
# **************************************************if...else usage (end)************************************************************************************


# **************************************************while usage (begin)************************************************************************************

set list_to_filled "";# declare an empty list to be filled 
set list18 {a b c d e f g h}
set i [expr [llength $list18]-1];# set i as the [length_list -1] to be used in the while loop 
puts "i:$i";# the length of list18
while {$i>=0} {
				lappend list_to_filled [lindex $list18 $i];# for each 1, append the ith element to the end of the list
				incr i -1;# i = 1 - 1
#note: syntax "incr i -1", you can't write as "incr i - 1", which means there is no blank space between "-" and 1 (in TCL, it means minus one )
}
puts "list_to_filled:$list_to_filled"


# **************************************************while usage (end)************************************************************************************



# **************************************************for usage (begin)************************************************************************************
# the syntax of "for" are as following:
#for {initialization} {condition} {increment} {
#   statement(s);
#}


set list_to_filled2 ""
set list19 {1 2 3 4 5 6}
set i2 [expr [llength $list19]-1];# obtain the length of i2
puts "i2: $i2"
for {set i [expr [llength $list19]-1]} {$i >= 0} {incr i -1} {;# 1. set i as the lenth of list19; 2. if i larger or equal to 0, conduct the following codes; 3 .i = i-1; judge i larger than 0 or equal to 0 to determine whether conduct following codes
				puts "$i"
				lappend list_to_filled2 [lindex $list19 $i]
				};# append the element in list19 to the end of the list_to_filled2 in reversed order
puts "list_to_filled2:$list_to_filled2"


for { set a 0}  {$a < 10} {incr a} {
   puts "value of a: $a"
};# a from 0 to 10 increament and print a


# **************************************************for usage (end)************************************************************************************



# **************************************************foreach usage (begin)************************************************************************************
#syntax of foreach are as followings:
# foreach varName list body

set b ""
set list20 {aa bb cc dd}
foreach i $list20 {;#for each loop, i obatian the element (aa bb cc dd), respectively.
				set b [linsert $b 0 $i];# [linsert $b 0 $i] means insert $i as the first element in $b, finally return to $b
				puts "b($i):$b"
}
puts "b:$b";# the result of b is {dd cc bb aa}

   
set x {}
foreach {i j} {a b c d e f} {;# there are 3 loop here.
   lappend x $j $i
	 puts "x:$x"
}

puts "x: $x"

set x2 ""
set list21 {1 2 3 4 5 6}
foreach i $list21 {;# there are 6 loop
				lappend x2 $i;# append $i to the end of x2
				puts "x2;$x2"
}
puts "x2;$x2"



# **************************************************foreach usage (end)************************************************************************************



# **************************************************break usage/continue uasge (begin)************************************************************************************
puts "a > 15 and break"
set a 10
while {$a < 20} {
				puts "value of a: $a"
				incr a
				if {$a > 15} {
								break};# break means: force the "while" loop end (these iterations of {$a > 15} would not occur)
				puts "value of a (twice): $a"
				
}


puts "a > 15 and continue"
set a 10
while {$a < 20} {
				puts "value of a: $a"
				incr a
				if {$a > 15} {
								continue;# continue means: end this iteration instead of the whole "while" loop (just the iteration when meeting {$a > 15})
				}
				puts "value of a (twice): $a"

}


puts "a == 15 and break"
set a 10
while {$a < 20} {
				puts "value of a: $a"
				incr a
				if {$a == 15} {
								break

				}
				puts "value of a (twice): $a"

}

puts "a == 15 and continue"
set a 10
while {$a < 20} {
				puts "value of a: $a"
				incr a
				if {$a == 15} {
								continue
				}
				puts "value of a (twice): $a"

}

puts "a==5 and break"
for { set a 0}  {$a < 10} {incr a} {
	puts "value of a: $a"
	if {$a == 5} {
					break
	}
   puts "value of a(twice): $a"
}

puts "a==5 and continue"
for { set a 0}  {$a < 10} {incr a} {
	puts "value of a: $a"
	if {$a == 5} {
					continue
	}
   puts "value of a(twice): $a"
}
puts "continue in foreach"
set a1 {1 2 a b}
foreach i $a1 {
	if {$i == 2} {
						continue
		           }
	puts "i;$i"
}

puts "break in foreach"
set a1 {1 2 a b}
foreach i $a1 {
	if {$i == 2} {
						break
		           }
	puts "i;$i"
}



# **************************************************break usage/continue usage (end)************************************************************************************




# **************************************************switch usage (begin)************************************************************************************
set grade A
switch $grade {
				A {
								puts "Well done!"}
			  B {
								puts "Excellent."}
				C {
								puts "you passed"}
				D { 
								puts "pls try again"}
				default {
								puts "Invalid grade"}
}
puts "you grade is $grade"								

#Note:"switch" in TCL or C language is just like "case" in Verilog


# **************************************************switch usage (end)************************************************************************************


# **************************************************proc usage (begin)************************************************************************************
#proc syntax:
#proc procedureName {arguments} {
#   body
#}



proc helloWorld {} {;# there is no arguments
				puts "Hello World"
}
helloWorld

proc add {a b} {
				return [expr $a+$b]
}
add 10 6;# invoke "add" proc with inputs 10 and 6, the proc "add" would return 16 (but not return to a defined variable)
set add_result [add 10 7]; # invoke "add" proc with inputs 10 and 7, the proc "add" would return 17 to variable add_result
puts "add_result:$add_result"


proc mul {a b} {
				return [expr $a*$b]
}
mul 10 6
set mul_result [mul 10 7]
puts "mul_result:$mul_result"




proc add {a b} {
				return {[expr $a*$b] [expr $a+$b]};# note;1. all of the contents within {} would be considered as string; 2. the returned results in this line is  {[expr $a*$b] [expr $a+$b]} instead of {60 16}
}
add 10 6
set add_result [add 10 7]
puts "add_result:$add_result"

# proc return more than one results
proc add {a b} {
				set mul_var [expr $a*$b] 
				set add_var [expr $a+$b]
				puts "mul_var:$mul_var"
				puts "add_var:$add_var"
				set listin ""
				lappend listin $mul_var $add_var;# by using "lappend" to append more than one elements in listin, you can return more than one results 
				puts "listin;$listin"
				return $listin
}
#add 10 6
set add_result [add 10 7]
puts "add_result:$add_result"



# the following proc function is:
# input: a number list, which length is not fixed
# output: return the average value of the input list
set num_input1 {70 50 60 80}
proc average_f {number_input} {
     set sum 0
		 foreach index $number_input {
						 set sum [expr $sum + $index]
		 }
		 set length_num [llength $number_input]
		 set aver_num [expr $sum/$length_num]
		 return $aver_num
}

set average_result1 [average_f $num_input1]
puts "average_result1: $average_result1"

set num_input2 {70 50 60 80 100}
set average_result2 [average_f $num_input2]
puts "average_result2: $average_result2"

# a minority usage (not usually use) demo
proc add {a {b 100} } {;# the default value of second argument is 100, if there is second element transfered in, used the transfered value; if lack of the second element transfered in ,using default value
				puts "a: $a"
				puts "b: $b"
   return [expr $a+$b]
}
puts [add 10 30]
puts [add 10];# lack of second argument, use the default value 100, so return 110. 

puts "lack of input value, use default value"
proc add2 {val1 {val2 2} {val3 3}} {
		#		expr $val1+$val2+$val3
				return [expr $val1+$val2+$val3]
}
puts [add2 1]
puts [add2 1 20 ]
puts [add2 1 5 8]



# recursive procedure
puts "recursive procedure usage with proc"
proc factorial {number} {
   if {$number <= 1} {
      return 1
   } 
   return [expr $number * [factorial [expr $number - 1]]]
}
#puts [factorial 3]
#puts [factorial 5]


proc factorial {number} {
   if {$number <= 1} {
      return 1
   } 
   set num_minus_1 [expr $number -1]
   puts $num_minus_1

	 set num_minus_1_factirial_resul [factorial $num_minus_1]
	 puts num_minus_1_factirial_resul:$num_minus_1_factirial_resul


   set factorial_total [expr $number*$num_minus_1_factirial_resul]
	 
	 return $factorial_total

   #return [expr $number * [factorial [expr $number - 1]]]
}
puts "the factorial result of 3"
puts [factorial 3]

puts "the factorial result of 5"
puts [factorial 5]


# proc and args
proc add3 {val1 args} {;# in proc procedure, if the last element in input argument is args, it means the number of the input parameters are variable.when invoking, args represents a list including the elements after val1.
     set sum $val1
		 puts "val1:$val1"
		 puts "args:$args"
		 foreach i $args {
						         	puts "sum(before add):$sum"
                     	puts "i:$i"

                      incr sum $i
											puts "sum(after add):$sum"
		 }
		 return $sum
}
puts "res1:[add3 2]";# the num of the input argument is 1
puts "***************"
puts "res2:[add3 2 4 5]";# the num of the input argument is 3

# investigate the local variable and global variable differece
set a1_1 2
set x1 3
puts "a1_1:$a1_1"

proc local_golal_var {x1} {
			global a1_1;# if you wanna use a global variable in a proc, you must declare "global a1_1", otherwise, TCL can't recognize the golbal defined variable
			puts "a1_1:$a1_1"
      incr a1_1;# when gloabl varibal value was changed in a proc, the global value of a1_1 changed  
			puts "a1_1:$a1_1"
			
			return [expr $x1+$a1_1]
}
puts "local_golal_var:[local_golal_var $x1]"
puts "a1_1:$a1_1";# when gloabl varibal value was changed in a proc, the global value of a1_1 changed  

# **************************************************proc usage (end)************************************************************************************


#**********************************************************************************************************************************************************************
# **************************************************the control flow in TCL (end)************************************************************************************
#**********************************************************************************************************************************************************************



















puts "**********finish_TCL_script_time = [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]**********"


















#!/usr/bin/tclsh
