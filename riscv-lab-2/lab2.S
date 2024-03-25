// Lab 2 template file
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    .asciz "ece 362 is awesome!"

.global login_name
login_name:
    .asciz "adannhau"

.global puid
puid:
    .asciz "0033498781"

// Align to 4bytes boundary as we have a string above
.balign 4

.text
.global asm_strlen
asm_strlen:
    /* uint32_t asm_strlen(char *str)
     * Take in a pointer to a string and return
     * its length up to the null terminating
     * character `\0`
    **/   

    /* Enter your code after this comment */
    li x11, 0   // x11 = 0  shifter
    li x12, 0   // x12 = 0  counter
    beq x10, x0, done   // check if a nullptr is passed in
    loop: add x11, x12, x0      // adds x12 to x11 to increment x11 to the next address (starts at zero address)
          add x11, x11, x10     // x11 + x10 moves the x11 value to the next character address
          lb x13, 0(x11)        // loads value pointed to by x11 into x13 (char are 1 byte)
          beq x13, x0, done     // check if the character is equal to \0 increment x12 (if they are equal I don't want to increment and I finish the program)
          addi x12, x12, 1      // increment x12 by 1
          beq x0, x0, loop      // sends us back to start
    done:
    add x10, x0, x12            // set x10 to the value in x12

    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* void asm_fib(int *arr, uint32_t length)
     * Accept a pointer to an array of integer and
     * the length of the array, then generate fibonacci
     * series starting at `0` and store the result
     * back to the array `arr` at corresponding indices.
     **/

    /* Enter your code after this comment */
    beq x10, x0, done2      // if array is empty don't do anything
    beq x11, x0, done2      // if length is zero don't do anything
    li x12, 0              // x12 = 0, this is our counter
    li x13, 0              // prev
    li x14, 1               // curr
    li x7, 1                // load 1 value
    loop2:  bge x12, x11, done2
            bne x12, x0, _elif      // if x12 != 0 jump to _elif
                    sw x13, 0(x10)      // load 0 into 0th position
                    jal x0, _end_if     // skip other branches
            _elif:  
                    bne x12, x7, _else   // if x12 != 1 jump to _else
                    sw x14, 0(x10)      // load 1 into 1st position
                    jal x0, _end_if     // skip other branches
            _else:
                    //li x6, 4                // load the value 4
                    //mul x5, x12, x6         // get offset i * 4
                    //add x15, x10, x5        // add byte offset to starting address and store it in x15                    
                    mv x6, x14               // set temp 6 to curr
                    add x14, x13, x14        // get new fibonacci #
                    mv x13, x6            // replace prev with curr
                    sw x14, 0(x10)          // load value into array[i]
            _end_if:
            
            
            
            addi x12, x12, 1        // increment counter
            addi x10, x10, 4
            
            jal x0, loop2
    done2:
    
    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* void asm_toUppercase(char *str)
     * loop through an entire string and only convert
     * the lowercase letter to uppercase, leaving the
     * rest of the string intact
     **/

    /* Enter your code after this comment */
    beq x10, x0, done3      // if the string is null do nothing

    li x5, 0x7B         // store if statement checker values
    li x6, 0x61
    li x7, 32
    lb x11, 0(x10)          // load first char of string
    loop3:  beq x11 , x0, done3     // if character is equal to \0 finish
        bge x11, x5, _iter    // if x11 is greater than 'z' jump to iter
        blt x11, x6, _iter    // if x11 is less than 'a' jump to iter
            sub x11, x11, x7    // x11 is lower case make it upper case
            sb x11, 0(x10)      // store char back in string
        _iter:
        addi x10, x10, 1    // increment pointer
        lb x11, 0(x10)      // update char
        jal x0, loop3
    done3:
    /* Enter your code above this comment */
    ret
