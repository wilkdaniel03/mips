# Design / Instruction cache

### Dictionary
* cache - specific type of memory being designed
* memory - memory storing instructions being executed and stored in *cache*

### Problem
In multi-pipelined systems arises problem of concurrent instruction access.
Typically memory allows for read/write only single memory cell at a time.
Thus some kind of specialized memory is needed.

### Description
The cache provides two capabilities.
* Write - overriding least recently used cell with new data, keeping track actual memory address.
* Read - reading data from cache using effective address in memory.

### Pinout
* clock(clk)
* write enable(wr_en)
* read enable(rd_en)
* effective write address(wr_addr)
* effective read address(rd_addr)
* write data(wr_data)
* read data(rd_data)

<img src="https://github.com/wilkdaniel03/mips/blob/master/assets/instruction_cache_pinout.png" width="50%">

### Components
* CAM - allowing to translate effective address onto cache memory address.
* CAM Memory - block of cells, each consisting of comparator and latch register.
* Ring Buffer - specific buffer allowing to override least recently used cell.

<img src="https://github.com/wilkdaniel03/mips/blob/master/assets/instruction_cache_components.png" width="50%">

### Constraints
* Latency - all operations must be done in **exactly 1 clock cycle**
