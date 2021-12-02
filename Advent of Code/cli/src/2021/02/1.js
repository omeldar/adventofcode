const fs = require('fs');

fs.readFile('input1.txt', 'utf8' , (err, data) => {
  if (err) {
    console.error(err);
    return
  }
  // arange input
  let inputData = data.split("\r\n");
  let commandArr = [];
  for(let i = 0; i < inputData.length; i++){
      let command = {
          instruction: inputData[i].split(" ")[0],
          value: parseInt(inputData[i].split(" ")[1])
      }
      commandArr.push(command);
      //console.log(command);
  }

  
  // run program
  let currentHorizontal = 0;
  let currentVertical = 0;
  for(let i = 0; i < commandArr.length; i++){
      switch(commandArr[i].instruction){
        case "down":
            currentVertical += commandArr[i].value;
            break;
        case "forward":
            currentHorizontal += commandArr[i].value;
            break;
        case "up":
            currentVertical -= commandArr[i].value;
            break;
      }
  }

  // display result
  console.log(currentHorizontal * currentVertical);
});
