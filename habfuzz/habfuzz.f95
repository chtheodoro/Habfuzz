!HABFUZZ 2.8
!Copyright © 2020 Christos Theodoropoulos
    
!Licensed under the Apache License, Version 2.0 (the "License");
!you may not use this file except in compliance with the License.
!You may obtain a copy of the License at

!http://www.apache.org/licenses/LICENSE-2.0

!Unless required by applicable law or agreed to in writing, software
!distributed under the License is distributed on an "AS IS" BASIS,
!WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!See the License for the specific language governing permissions and
!limitations under the License.

program habfuzz
use fdeclarations

implicit none

write(*,*) ' '
write(*,*) ' __    __    __    _____  ________   ________________ '   
write(*,*) '|  |  |  |  /  \  |     \|   __   | |   ___   |___   |'
write(*,*) '|  |__|  | / [] \ |  []  \  |_ |  | |  |  /  /   /  / '
write(*,*) '|   __   |/  __  \|      /   _||  | |  | /  /   /  /  '
write(*,*) '|  |  |  |  /  \  |  []  \  |  |  |_|  |/  /___/  /__ '
write(*,*) '|__|  |____/    \________/__|   \_____//__________2.8|'  
write(*,*) '                                                      '
write(*,*) '[1] Run HABFUZZ'
write(*,*) '[2] I need some help'
read *, start
print *, ' '
if (start==2) then
print *, 'With HABFUZZ, you can calculate the value of a'
print *, 'variable (response variable), based on the values of other'
print *, 'variables (predictors) using fuzzy logic and fuzzy rule-based'
print *, 'Bayesian algorithms.' 
print *, ' '
print *, 'Press Enter to Continue...'
read(*,*)
print *, 'You need an input file with known predictor/response'
print *, 'values, e.g.:'
print *, '| WATER DEPTH | FLOW VELOCITY | SUBSTRATE | -> | SUITABILITY|'
print *, '| 0.5         | 0.3           | Boulders  | -> | 0.6        |'
print *, '| 0.4         | 0.8           | Gravel    | -> | 0.5        |'
print *, '| 0.7         | 0.2           | Cobbles   | -> | 0.8        |'
print *, '| 0.2         | 1.2           | Cobbles   | -> | 1.0        |'
print *, '| 1.2         | 1.1           | Boulders  | -> | 0.9        |'
print *, ' '
print *, 'Press Enter to Continue...'
read(*,*)
print *, 'HABFUZZ will use this file as a training dataset and will run'
print *, 'fuzzy rule-based algorithms to predict the response variable'
print *, 'in a dataset with known predictors but unknown response'
print *, 'variable, e.g.:'
print *, ' '
print *, '| WATER DEPTH | FLOW VELOCITY | SUBSTRATE | -> | SUITABILITY|'
print *, '| 0.1         | 0.2           | Gravel    | -> | Unknown    |'
print *, '| 0.2         | 0.5           | Gravel    | -> | Unknown    |'
print *, '| 0.7         | 0.1           | Boulders  | -> | Unknown    |'
print *, '| 0.3         | 0.2           | Cobbles   | -> | Unknown    |'
print *, '| 1.1         | 0.6           | Boulders  | -> | Unknown    |'
print *, ' '
print *, 'Press Enter to Continue...'
read(*,*)
print *, 'You can do this for thousands of predictor combinations.'
print *, 'Look at the very detailed HABFUZZ manual for how to prepare'
print *, 'your input files (traindata.txt, testdata.txt, fuzzysets.txt).' 
print *, 'Once you do this, HABFUZZ will do all the hard work for you'
print *, 'with only a couple of clicks.'
print *, ' '
print *, 'Press Enter to Continue...'
read(*,*)
print *, 'You can explore the accuracy of all fuzzy logic algorithms'
print *, 'but still, I prefer the fuzzy Bayesian one, it is faster and'
print *, 'most times more accurate.'
print *, ' '
print *, 'Train, cross-validate and test using HABFUZZ fuzzy logic.'
print *, 'If you need any help contact me at ctheodor@hcmr.gr'
print *, 'Christos Theodoropoulos'
print *, ' '
print *, 'Press Enter to run HABFUZZ'
read(*,*)
else
call cpu_time(ta)
end if
!Opening the data to develop the rules
256 print *, 'Select HABFUZZ version'
print *, '[1] HABFUZZ classic: 5-5-8-5 fuzzy inputs'
print *, '[2] HABFUZZ fuzzy: 5-5-5-5 full fuzzy inputs'
print *, '[3] I have no idea, please help!'
read *, vers
print *, ' '

if (vers==3) then
print *, 'HABFUZZ classic includes three 5-class fuzzy inputs and one'
print *, '8-class crisp input (not fuzzy). You can select this HABFUZZ'
print *, 'version as, for example, a habitat model, in which the first'
print *, 'fuzzy input is flow velocity, the second fuzzy input is the'
print *, 'water depth, the third input (not fuzzy) is the substrate'
print *, 'type, and the fourth fuzzy input is water temperature.'
print *, ' '
print *, 'Press Enter to Continue'
read(*,*)
print *, 'HABFUZZ fuzzy includes four 5-class fuzzy inputs. You can'
print *, 'select this version for every other use, in which a response'
print *, 'variable is to be calculated using fuzzy logic or fuzzy'
print *, 'Bayesian algorithms.'
print *, ' '
print *, 'Press Enter to Continue'
read(*,*)
print *, 'Make sure you have properly prepared yout training dataset'
print *, '(traindata.txt), your test dataset (testdata.txt) and the'
print *, 'fuzzy membership functions (fuzzysets.txt).'
print *, ' '
print *, 'If you need any help contact me at ctheodor@hcmr.gr'
print *, 'Christos Theodoropoulos'
print *, ' '
print *, 'Press Enter to run HABFUZZ'
read(*,*)
end if
if (vers==3) then
GOTO 256
else
GOTO 257
end if

257 call reader
open (unit=99, file='traindata.txt', status='old', action='read') !The data matrix
read (99,*) n
if (vers==1) then
open (unit=89, file='refdata_hc.txt', status='old', action='read') !The reference data matrix to acquire all class combinations
read (89,*) e
else
open (unit=89, file='refdata_hff.txt', status='old', action='read') !The reference data matrix to acquire all class combinations
read (89,*) e
end if

allocate(rmatrix(e,w-1)) !Allocate the data matrix
allocate(matrix(n,w)) !Allocate the reference data matrix
allocate(cmatrix(n,w)) !This initiates the matrix where the train data are classified row by row
o=90*n
if (mod(o,100)==0) then
ii=o/100
else
ii=int(o)/100
end if
z=n-ii
allocate(a1(n*10))
allocate(suitability(z,10))
allocate(aa(z,10))
allocate(comatrix(z,3,10))
comatrix(:,:,:)=0
allocate(co1matrix(z,10))
allocate(icci(10))
l=1
do i=1,n
read(99,*) (matrix(i,j), j=1,w)
end do
do i=1,e
read(89,*) (rmatrix(i,j), j=1,w-1)
end do


print *, 'Select modelling method'
print *, '[1] Fuzzy logic algorithms'
print *, '[2] Fuzzy Bayesian algorithm'
read *, proc
print *, ' '

if (proc==1) then
print *, 'Select cross-validation scheme'
print *, '[1] Monte Carlo'
print *, '[2] Do not cross-validate'
read *, cross
call fuzzy

else
print *, 'Select cross-validation scheme'
print *, '[1] Monte Carlo'
print *, '[2] Ten fold'
print *, '[3] Do not cross-validate'
read *, cross
if (cross==1) then
write(*,*) ' '
write(*,*) 'Initializing fuzzy Bayesian inference...'
call sleep(2)
do zz=1,10
write(*,*) ' '
write(*,*) 'ITERATION', zz
write(*,*) '----------------------'
call sleep(2)
call randomizer
call iterator

write(*,*) 'Developing rules database...'
call classifier

open(49, file='log.txt', action='write', status='replace')
write(49,*) ' Classification matrix'
write(49,*) ' V      D      S      T      HS'  
do i=1,ii
write(49,10) (cmatrix(i,j), j=1,w)
end do

!write(49,*) ' '
!write(49,*) 'rmatrix'
!do i=1,e
!write(49,10) (rmatrix(i,j), j=1,w-1)
!end do

call combinations

open (unit=59, file='amatrix.txt', status='old', action='read')
read (59,*) nn

allocate(amatrix(nn,w-1))

do i=1,nn
read(59,*) (amatrix(i,j), j=1,w-1)
end do

call ruler

!write(49,*) ' '
!write(49,*) 'p1matrix'
!do i=1,nn
!write(49,10) (p1matrix(i,j), j=1,w+1)
!end do

write(49,*) ' '
write(49,*) ' Bayesian joint probabilities matrix'
write(49,*) ' H      G      M      P      B'
do i=1,nn
write(49,10) (p2matrix(i,j), j=1,w)
end do

do i=1,nn
write(49,10) (amatrix(i,j), j=1,w-1)
end do

write(*,*) 'Development of rules successful!'
write(*,*) ' '
call sleep(2)

write(*,*) 'Fuzzifying inputs...'
call fuzzifier
!write(49,*) ' '
!write(49,*) 'V Fuzzification'
!do i=1,n
!write(49,10) (uf(i,j), j=1,e)
!end do

!write(49,*) ' '
!write(49,*) 'D Fuzzification'
!do i=1,n
!write(49,10) (df(i,j), j=1,e)
!end do

!write(49,*) ' '
!write(49,*) 'S Classes'
!do i=1,n
!write(49,10) (sf(i,j), j=1,e)
!end do

!write(49,*) ' '
!write(49,*) 'T Fuzzification'
!do i=1,n
!write(49,10) (tf(i,j), j=1,e)
!end do
write(*,*) 'Fuzzification successful!'
write(*,*) ' '

write(*,*) 'Applying Bayesian joint probability rules...'
write(*,*) ' '
call sleep(2)
allocate(bmatrix(e**(w-1),w-1,z))
allocate(bayh(nn,z))
allocate(bayg(nn,z))
allocate(baym(nn,z))
allocate(bayp(nn,z))
allocate(bayb(nn,z))
allocate(fmatrix(nn,w-1,z))

do i=1,z
open(29, file='bmatrix.txt', action='write', status='replace')
write(29,*) nn
call permutator
close(29, status='keep')

open (unit=39, file='bmatrix.txt', status='old', action='read')
read (39,*) nn
do jj=1,nn
read(39,*) (fmatrix(jj,j,i), j=1,w-1)
end do
close(39, status='keep')
do j=1,nn
bayh(j,i)=product(fmatrix(j,:,i))*p2matrix(j,1)
bayg(j,i)=product(fmatrix(j,:,i))*p2matrix(j,2)
baym(j,i)=product(fmatrix(j,:,i))*p2matrix(j,3)
bayp(j,i)=product(fmatrix(j,:,i))*p2matrix(j,4)
bayb(j,i)=product(fmatrix(j,:,i))*p2matrix(j,5)
end do
write(*,*) 'Rules application for observation', i, 'successful'
end do
write(*,*) ' '
write(*,*) 'Rules application successful!'
write(*,*) ' '
write(*,*) 'Calculating Bayesian joint probabilities...'
call sleep(2)
!write(49,*) ' '
!write(49,*) 'fmatrix'
!do i=1,nn
!write(49,10) (fmatrix(i,j,jj), j=1,w-1)
!end do
write(*,*) 'Joint probability calculation successful!'
write(*,*) ' '
print *, 'Calculating response variable...'
call sleep(2)
write(*,*) ' '
do i=1,z
write(*,*) 'Response variable calculation for observation', i, 'successful'
bayg1(i)=sum(bayg(1:nn,i))
baym1(i)=sum(baym(1:nn,i))
bayh1(i)=sum(bayh(1:nn,i))
bayp1(i)=sum(bayp(1:nn,i))
bayb1(i)=sum(bayb(1:nn,i))
end do
write(*,*) ' '
write(*,*) 'Response variable calculation successful!'

call rules2
!write(49,*) ' '
!write(49,*) 'bayH1'
!do i=1,n
!write(49,10) (bayh1(i))
!end do

!write(49,*) ' '
!write(49,*) 'bayb'
!do i=1,nn
!write(49,10) (bayb(i,j), j=1,n)
!end do

write (49,*) ' '
write (49,*) ' Joint probability of High suitability class'
do i=1,z
write(49,10) (bayh2(i))
end do

write (49,*) ' '
write (49,*) ' Joint probability of Good suitability class'
do i=1,z
write(49,10) (bayg2(i))
end do

write (49,*) ' '
write (49,*) ' Joint probability of Moderate suitability class'
do i=1,z
write(49,10) (baym2(i))
end do

write (49,*) ' '
write (49,*) ' Joint probability of Poor suitability class'
do i=1,z
write(49,10) (bayp2(i))
end do

write (49,*) ' '
write (49,*) ' Joint probability of Bad suitability class'
do i=1,z
write(49,10) (bayb2(i))
end do

ik=1
do i=1,z
hs(i)=bhigh(i)+bgood(i)+bmoderate(i)+bpoor(i)+bbad(i)
if (bayg1(i)<=0 .and. bayh1(i)<=0 .and. baym1(i)<=0 .and. bayp1(i)<=0 .and. bayb1(i)<=0) then
134 if (suitability(i-ik,zz)<=0) then
ik=ik+1
goto 134
else
suitability(i,zz)=suitability(i-ik,zz)
end if
else
suitability(i,zz)=hs(i)
end if
end do

!open(19, file='suitability.txt', action='write', status='replace')
!do i=1,z
!write(*,10) (suitability(i,zz))
!end do
!read(*,*)
deallocate(a)
deallocate(bins)
deallocate(iimatrix)
deallocate(amatrix)
deallocate(p1matrix)
deallocate(p2matrix)
deallocate(uf)
deallocate(df)
deallocate(tf)
deallocate(sf)
deallocate(imatrix)
deallocate(dmatrix)
deallocate(ematrix)
deallocate(bmatrix)
deallocate(fmatrix)
deallocate(bayh)
deallocate(bayg)
deallocate(baym)
deallocate(bayp)
deallocate(bayb)

close(49, status='keep')
close(59, status='keep')
!close(19, status='keep')
call performance

write(*,44) ' Performance - CCI  ', icci(zz)*100, ' %'

end do
write(*,*) ' '
write(*,*) 'End of cross-validation process!'
write(*,*) ' '
else if (cross==2) then
call tencrossval
else if (cross==3) then
write(*,*) ' '
GOTO 199
end if

!open(119, file='loga.txt', action='write', status='replace')
!open(109, file='logb.txt', action='write', status='replace')
!write(119,*) 'comatrix2'
!do i=1,z
!write(119,10) (comatrix(i,2,ff), ff=1,10)
!end do
!write(109,*) 'comatrix1'
!do i=1,z
!write(109,10) (comatrix(i,1,ff), ff=1,10)
!end do
!write(109,*) 'comatrix3'
!do i=1,z
!write(109,10) (comatrix(i,3,ff), ff=1,10)
!end do
!write(109,*) 'suitability'
!do i=1,z
!write(109,10) (suitability(i,ff), ff=1,10)
!end do
!write(109,*) 'icci'
!write(109,*) icci
cci=(sum(icci(1:10))/10)*100
!write(109,*) cci
!close(109, status='keep')
call sleep(2)
199 CONTINUE
z=n
zz=1
call tester
end if
allocate(cs(ee))
allocate(habcon(ee))
allocate(gwet(ee))
allocate(wet(ee))

do i=1,ee
if (s(i,zz)>0) then
cs(i)=1
else
cs(i)=0
end if
end do

!Habitat connectivity (habcon and habc)
do i=1,ee
if (testmat(i,2)>0 .and. s(i,zz)>0.6) then
gwet(i)=1
else
gwet(i)=0
end if
end do

do i=1,ee
if (s(i-1,zz)>0.6 .and. s(i,zz)>0.6) then
habcon(i)=1
else
habcon(i)=0
end if
end do

!Wetted nodes
do i=1,ee
if (testmat(i,2)>0) then
wet(i)=1
else
wet(i)=0
end if
end do

pwet=sum(((wet)/ee)*100)
osi=real(sum(s))
nosi=osi/(sum(cs))
cert=anint((sum(cer)/ee)*100)
habc=anint((sum(habcon)/sum(gwet))*100)
haba=anint((sum(habcon)/ee)*100)

if (cross .ne. 3) then
open (unit=39, file='bmatrix.txt', status='old', action='read')
close (39, status='delete')
else
goto 599
end if

599 open (unit=59, file='amatrix.txt', status='old', action='read')
close (59, status='delete')

write(*,*) ' '
write(*,*) 'Finished!'
write(*,*) ' '
write(*,44) ' Overall model performance      ', cci, ' %'
write(*,44) ' Percent wetted nodes           ', pwet, ' %'
write(*,*) 'Certainty of prediction  ', cert, '%'
write(*,*) 'Habitat connectivity     ', habc, '%'
write(*,*) 'Habitat availability     ', haba, '%'

write(*,100) ' Overall Suitability Index - OSI  ', osi
write(*,100) ' Normalized OSI                ', nosi

100 format (a,10f10.3)
44 format (a,f6.2,a)
write(*,*) ' '
print *, 'Writing results to files...'
print *, ' '
call sleep(2)
print *, 'Results ready'
print *, 'End of process'
print *, 'Please check the created file output.txt'
print *, ' '
call cpu_time(tb)
write(*,44) ' Elapsed time ', (tb-ta)/60, ' minutes'
write(*,*) 'Thank you for using HABFUZZ!'
print *, char(7)
write(*,*) 'Press ENTER to exit'
read(*,*)
10 format (10f7.3)
end program habfuzz
