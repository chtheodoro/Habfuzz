module test_rules
use fdeclarations
use fruit

implicit none

contains
subroutine sum_of_probability_values_should_be_1 
real :: ref=1, ref0=0
real :: totalp
n=10
uvl(1:n)=(/0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 1.000, 0.000, 0.000/)
ul(1:n)=(/0.800, 0.600, 0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.200, 1.000/)
um(1:n)=(/0.200, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.800, 0.000/)
uh(1:n)=(/0.000, 0.000, 0.000, 0.000, 1.000, 0.000, 1.000, 0.000, 0.000, 0.000/)
uvh(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 0.000/)
dvs(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 0.333, 0.000, 0.000/)
ds(1:n)=(/0.000, 0.000, 1.000, 1.000, 0.000, 0.000, 0.000, 0.667, 0.000, 0.000/)
dm(1:n)=(/1.000, 1.000, 0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 1.000, 0.000/)
dd(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000/)
dvd(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000/)
bld(1:n)=(/0.000, 0.000, 1.000, 1.000, 0.000, 0.000, 1.000, 0.000, 0.000, 1.000/)
ls(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 0.000/)
ss(1:n)=(/1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000/)
lg(1:n)=(/0.000, 1.000, 0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 1.000, 0.000/)
mg(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000/)
fg(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000/)
sand(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 0.000, 0.000/)
silt(1:n)=(/0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000/)

call rules
do i=1,5
totalp=bayh1(i)+bayg1(i)+baym1(i)+bayp1(i)+bayb1(i)
call assert_equals(ref, totalp, 0.02)
end do

do i=8,10
totalp=bayh1(i)+bayg1(i)+baym1(i)+bayp1(i)+bayb1(i)
call assert_equals(ref, totalp, 0.02)
end do

do i=6,7
totalp=bayh1(i)+bayg1(i)+baym1(i)+bayp1(i)+bayb1(i)
call assert_equals(ref0, totalp, 0.02)
end do

end subroutine sum_of_probability_values_should_be_1
end module test_rules
 
