const fs = require('fs');

fs.readFile('input1.txt', 'utf8' , (err, data) => {
    if (err) {
        console.error(err);
        return
    }
    // arange
    let inputByLineArr = data.split("\r\n");
    let counters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    // run program
    inputByLineArr.forEach((inputBArray) => ([...inputBArray].map(n => parseInt(n))).forEach((b,i) => counters[i] += b)); //foreach line, make array of bits of the line then sum counters[i] with currentLineArr[i] into counters[i]

    // display result
    let result = 0;
    console.log(`\nresult: ${result}`);
});
