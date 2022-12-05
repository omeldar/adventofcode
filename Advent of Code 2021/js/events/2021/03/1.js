const fs = require('fs');

fs.readFile('input1.txt', 'utf8' , (err, data) => {
    if (err) {
        console.error(err);
        return
    }
    // arange input
    let inputByLineArr = data.split("\r\n");
    let gamma = [];
    let epsilon = [];
    let counters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    // run program
    inputByLineArr.forEach((inputBArray) => ([...inputBArray].map(n => parseInt(n))).forEach((b,i) => counters[i] += b));
    counters.forEach((c) => (c < 500) ? gamma.push(0) : gamma.push(1));
    gamma.forEach((g) => (g == 1) ? epsilon.push(0): epsilon.push(1));

    // display result
    let result = parseInt(gamma.join(""), 2) * parseInt(epsilon.join(""), 2);
    console.log(`\nresult: ${result}`);
});
