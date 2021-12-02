const { exec } = require("child_process");
const path = require("path");
const fs = require('fs');

export async function runScript(options) {
    let dayFormatted = 0;
    if(options.day < 10)
        dayFormatted = "0" + options.day.toString();
    else
        dayFormatted = options.day;

    let pathInSrc = path.join(options.year.toString(), dayFormatted, options.part.toString());
    if(!options.showInput){ // if user did not specify to get only input
        exec("node " + options.part + '.js', 
        { 
            cwd: path.join('src',options.year.toString(), dayFormatted )
        }, 
        (error, stdout) => {
            if(error){
                if(options.debug){
                    console.error(error);
                    console.log("");
                }   
                else {
                    console.log('🎅 Ohh, something weird happened. Run this command with --debug to see full information.\n');
                }
            }
            if(stdout){
                console.log(`🎅 ${pathInSrc}: ${stdout}`);
            }
        })
    }
    else{   // user specified to get input of that day
        let fileName = "input1.txt";
        // if options.part is 2 and a file named input2.txt exists, use input2.txt. If not just input1.txt specified above will be used.
        if(fs.existsSync(path.join('src', options.year.toString(), dayFormatted, 'input2.txt')) && options.part == 2)
            fileName = "input2.txt";
        
        exec("type " + fileName, {
            cwd: path.join('src',options.year.toString(), dayFormatted )
        }, (error, stdout) => {
            if(error){
                if(options.debug){
                    console.error(error);
                    console.log("");
                }   
                else {
                    console.log('🎅 Ohh, something weird happened. Run this command with --debug to see full information.\n');
                }
            }
            if(stdout){
                console.log(`🎅 ${pathInSrc} input: ${stdout}`);
            }
        })
    }

}