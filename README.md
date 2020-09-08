### EvenOdd-Synchronizer
This shows an [EvenOdd-Synchronizer](https://research.nvidia.com/sites/default/files/pubs/2010-05_The-Even/Odd-Synchronizer%3A//05476986.pdf) implementation by a research paper from a Nvidia Research Group.

A all-digital synchronizer that moves multi-bit Signals between two periodic 
clock domains with an average delay of sligthly more than a  half cycle and 
an arbitrarily small probability of synchronization failure.
The synchronizer operates by measuring the relative frequency of the two periodic
clocks and using this frequency measurement, along with a phase
detection, to compute a phase estimate. 
Interval arithmetic is used for the phase estimate to account for uncertainty. 
The transmitter writes a pair of registers on alternating clock cycles and the
receiver uses the estimate of the transmitter’s phase to always
select the most recently written value that is safe to sample.

The synchronizer should work for all frequency combinations, according the [research paper](https://research.nvidia.com/sites/default/files/pubs/2010-05_The-Even/Odd-Synchronizer%3A//05476986.pdf).

